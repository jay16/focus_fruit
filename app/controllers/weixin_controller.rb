#encoding: utf-8
class WeixinController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :receve_xml,   except: [:authen, :show]
  before_filter :record_weixin, except: [:authen, :show]
  
  respond_to :xml, :html, :js

  def event; end
  def receive; end
  def other; end

  def menu
    content = params[:xml][:Content]
    match = menu_match(content)

    case match[0]
    when "b"
      @fruit_zones = FruitZone.where("state='onsale'")
      @info = "今日特惠： \n"
      @fruit_zones.each_with_index do |fruit_zone,index|
	@info << "1.#{fruit_zone.list} #{fruit_zone.name}\n"
      end
    when "1" #水果专区
      @fruit_zones = FruitZone.where("state='onsale'")
      if zones = @fruit_zones.select { |zone| zone.list == match[1].to_i }
        @fruit_zone = zones.first
      end
    when "2" #达人服务
      case match[1].to_i
      when 1
        @info = menu_service(@weixin,"shop")
      when 2
        @info = menu_service(@weixin,"distribution")
      when 3
        @info = menu_service(@weixin,"payment")
      when 4
        @info = menu_service(@weixin,"call-center")
      end
    when "3" #我的生活
      case match[1].to_i
      when 1
        order = Order.find_by_weixin(@weixin.from_user_name)
	@info = menu_query(order)
      when 2
        @blogs = Blog.where("klass='blog'")
      end
    end

    if @fruit_zone
      render template: "weixin/fruit_zone"
    elsif @blogs
      render template: "weixin/blog"
    else
      unless @info
	@fruit_zones = FruitZone.where("state='onsale'").order("list asc")
	@info = menu_help( @fruit_zones)
      end
      render template: "weixin/menu"
    end
  end


  def menu_service(weixin,type)
    info = "水果达人为您服务,请点击此处"
    url = "http://fruit.solife.us"
    case type
    when "distribution"
      url = "#{url}/#{type}"
      klass = "查看配送服务" 
    when "payment"
      url = "#{url}/#{type}"
      klass = "查看支付方式" 
    when "call-center"
      url = "#{url}/#{type}"
      klass = "查看电话客服" 
    else
      url = "#{url}?weixin=#{weixin.from_user_name}"
      klass = "开始选购水果" 
    end

    info << "<a href='#{url}'>#{klass}</a>"
  end

  def menu_query(order)
    info = "水果达人为您服务,"
    if order
      info << "您订单信息:\n"
      info << "水果数量:[#{order.count}],消费金额:[￥#{order.checkout}]."
      info << "订单状态:"
      info << "[#{order.status}]"
    else
      info << "未查询到您的订单"
    end
  end

  def menu_help(fruit_zones)
    url = "http://fruit.solife.us"
    help = "您好，越先越鲜，点击<a href='#{url}'>此处</a>开始选购吧。或回复字母[爱果]一下吧！\n"
    help << "A.会员尊享\n"
    help << "B.今日特惠\n"
    help << "C.在线订购\n"
    help << "D.预约新品\n"
    help << "E.配送新品\n"
    help << "F.果仁新作\n"
    help << "G.了解更多\n"

    #help << "水果信息\n" 
    #fruit_zones.each_with_index do |fruit_zone,index| 
    #  help << "1.#{fruit_zone.list} #{fruit_zone.name}\n"
    #end
    #help << "达人服务\n" 
    #help << " 2.1 在线订购\n"
    #help << " 2.2 配送服务\n"
    #help << " 2.3 支付方式\n"
    #help << " 2.4 电话客服\n"
    #help << "我的生活\n" 
    #help << " 3.1 订单查询\n"
    #help << " 3.2 达人心情\n"

    #help << "\n回复[?]显示此帮助菜单\n"
  end
 
  #个人查看weixin消息记录 
  def show
    @record = WeixinRecever.find(params[:id]) 
    render :layout => "layout_v2/application"
  end

  #weixin开发模式验证
  def authen
    if params[:nonce] #weixin服务器验证url
      array = ["iamjay", params[:timestamp], params[:nonce]].sort
      if params[:signature] == Digest::SHA1.hexdigest(array.join)
	render :text => params[:echostr]
      else
	render :text => "Forbidden", :status => 403 
      end
    else              #个人访问
      @records = WeixinRecever.order("created_at desc")
      render :template => "weixin/index"
    end
  end

  private

  def receve_xml
    @weixin = weixin_xml
  end

  def record_weixin
    xml = params[:xml]
    @record = WeixinRecever.create({
      :to_user_name   => xml[:ToUserName],
      :from_user_name => xml[:FromUserName],
      :create_time    => xml[:CreateTime],
      :msg_type       => xml[:MsgType],
      :msg_id         => xml[:MsgId],
      :content        => xml[:Content],
      :pic_url        => xml[:PicUrl],
      :media_id       => xml[:MediaId],
      :format         => xml[:Format],
      :thumb_media_id => xml[:ThumbMediaId],
      :location_x     => xml[:Location_X],
      :location_y     => xml[:Location_Y],
      :scale          => xml[:Scale],
      :label          => xml[:Label],
      :title          => xml[:Title],
      :description    => xml[:Description],
      :url            => xml[:Url],
      :event          => xml[:Event],
      :event_key      => xml[:EventKey],
      :ticket         => xml[:Ticket],
      :latitude       => xml[:Latitude],
      :longitude      => xml[:Longitude],
      :precision      => xml[:Precision]
    })
  end

  def menu_match(str)
    ret = [-1,-1]

    if str =~ /^\p{Alnum}*/
      ret[0] = $&.downcase
    end

    if str =~ /^\d*\.\d*/ 
      #"#{$`}<<#{$&}>>#{$'}"
      ret = $&.split(".")
    end

    return ret
  end
end
