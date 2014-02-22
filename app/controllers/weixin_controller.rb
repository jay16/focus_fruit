#encoding: utf-8
class WeixinController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :receve_xml,   except: [:authen, :show]
  before_filter :record_weixin, except: [:authen, :show]
  
  respond_to :xml, :html, :js

  #添加/取消关注 
  def event
    if @weixin.event == "subscribe"
      if (@fruits = Fruit.where("state='推荐'")).size == 0
        @fruits = Fruit.all.first(2)
      end
      render template: "weixin/menu_subscribe" 
    else
    end
  end

  def receive; end
  def other; end

  def menu
    content = params[:xml][:Content]
    match = menu_match(content)

    case content.to_s.downcase[0]
    when "b"
      @fruit_zones = FruitZone.find(1)#where("state='onsale'")
      @fruits = @fruit_zones.fruits
      render template: "weixin/menu_news"

      #@info = "今日特惠： \n"
      #@fruit_zones.each_with_index do |fruit_zone,index|
      #	@info << "1.#{fruit_zone.list} #{fruit_zone.name}\n"
      #end
    when "c" #在线订购
      @info = menu_service(@weixin,"shop")
      render template: "weixin/menu"
    when "d" #预约新品
      @fruit_zones = FruitZone.find(2)#where("state='onsale'")
      @fruits = @fruit_zones.fruits
      render template: "weixin/menu_news"
    when "e" #配送范围
      @info = menu_service(@weixin,"distribution")
      render template: "weixin/menu"
    when "f" #了解更多
      @blogs = Blog.where("klass in ('distribution','call-center','payment')")
      render template: "weixin/menu_blogs"
    when "g" #评论
      #评论为空
      if content.length > 1
	orders = Order.where("weixin='#{@weixin.from_user_name}'")
	           .order("created_at desc")
	#当前用户没有下过单
	if orders.size > 0
	  comment = content[1,content.length-1]
	  @info = "评论成功!\n"
	  @info << "评论内容:[#{comment}]\n"
	  items = orders.first.items 
	  @info << "您最近一笔订单的水果列表:"
	  items.each do |item|
	    if fruit = Fruit.find(item.fruit_id)
	      fruit.replies.create({
		:name => @weixin.from_user_name,
		:content => comment
	      })
	      @info << "\n<a href='#{fruit.link}?weixin=#{@weixin.from_user_name}#comments'>#{fruit.name}</a>"
	    end
	  end
	else
	  @info = "错误提示:没有您的成交记录\n"  
	  @info << "温馨提示:G开头的任意文字，都自动作为评论"
	end
      else
        @info = "错误提示:评论不可为空\n"
	@info << "温馨提示:G开头的任意文字，都自动作为评论"
      end
      render template: "weixin/menu"   
      #@info = menu_service(@weixin,"shop")
      #@info = menu_service(@weixin,"distribution")
      #@info = menu_service(@weixin,"payment")
      #@info = menu_service(@weixin,"call-center")
    else
      @info = menu_help(@weixin.from_user_name)
      render template: "weixin/menu"
    end

    #if @fruit_zone
    #  render template: "weixin/fruit_zone"
    #elsif @blogs
    #  render template: "weixin/blog"
    #else
    #  unless @info
    #	@fruit_zones = FruitZone.where("state='onsale'").order("list asc")
    #	@info = menu_help(@weixin.from_user_name)
    #  end
    #  render template: "weixin/menu"
   # end
  end


  #主菜单
  def menu_help(weixin)
    url_base = "http://fruit.solife.us"
    url_shop = "#{url_base}?weixin=#{weixin}"
    url_rmd  = "#{url_base}/recommends?weixin=#{weixin}"
    url_news = "#{url_base}/shop/news?weixin=#{weixin}"
    url_send = "#{url_base}/distribution?weixin=#{weixin}"
    url_list = "#{url_base}/list?weixin=#{weixin}"
    help = "您好，越先越鲜，点击<a href='#{url_shop}'>此处</a>开始选购吧。或回复字母[爱果]一下吧！\n"
    help << "A.会员尊享\n"
    help << "B.<a href='#{url_shop}'>今日特惠</a>\n"
    help << "C.<a href='#{url_shop}'>在线订购</a>\n"
    help << "D.<a href='#{url_news}'>预约新品</a>\n"
    help << "E.<a href='#{url_send}'>配送范围</a>\n"
    help << "F.<a href='#{url_list}'>了解更多</a>\n"
    help << "G. 评论[G+反馈内容]"
  end

  #菜单服务
  def menu_service(weixin,type)
    info = "[爱果]为您服务,请点击此处"
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
