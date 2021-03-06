#encoding: utf-8
require 'cgi'
class WeixinController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :receve_xml,   except: [:authen, :show]
  before_filter :record_weixin, except: [:authen, :show]
  
  respond_to :xml, :html, :js

  #添加/取消关注 
  def event
    if @weixin.event == "subscribe"
      #  if (@fruits = Fruit.where("state='推荐'")).size == 0
      #    @fruits = Fruit.all.first(2)
      #  end
      @site_config   = SiteConfig.find(1)
      @weixin_config = SiteConfig.find(3)
      @info = menu_help(@site_config,@weixin_config,@weixin.from_user_name)
      render template: "weixin/menu" 
    else
    end
  end

  def receive; end
  def other; end

  def menu
    content = params[:xml][:Content]
    match = menu_match(content)

    @site_config   = SiteConfig.find(1)
    @weixin_config = SiteConfig.find(3)

    case content.to_s.downcase[0]
    when "a" #会员尊享
      @info = menu_service(@site_config,@weixin_config,@weixin,"user")
      render template: "weixin/menu"
    when "b" #今日特惠
      @fruits = Fruit.where("state='recommand'")
      render template: "weixin/menu_fruits"
    when "c" #在线订购
      @info = menu_service(@site_config,@weixin_config,@weixin,"shop")
      render template: "weixin/menu"
    when "d" #预约新品
      @fruits = Fruit.where("state='new'")
      render template: "weixin/menu_fruits"
    when "e" #配送范围
      @blogs = Blog.where("klass='distribution'")
      render template: "weixin/menu_blogs"
    when "f" #了解更多
      @blogs = Blog.where("klass in ('service')")
      render template: "weixin/menu_blogs"
    when "g" #评论
      #评论为空
      if content.length > 1
	orders = Order.where("weixin='#{@weixin.from_user_name}'")
	           .order("created_at desc")
	comment = content[1,content.length-1]
	#当前用户没有下过单
	if orders.size > 0
	  #@info = "评论成功!\n"
	  #@info << "感谢您的评论:[#{comment}]\n"
	  @info = @weixin_config.text3
	  items = orders.first.items 
	  #@info << "您最近一笔订单的水果列表:"
	  @info << @weixin_config.text4 + "\n"

	  items.each do |item|
	    if fruit = Fruit.find(item.fruit_id)
	      fruit.replies.create({
		:name => @weixin.from_user_name,
		:content => comment
	      })
	      @info << "\n<a href='#{fruit.link}?weixin=#{@weixin.from_user_name}#comments'>#{fruit.name}</a>"
	    end
	  end
	#无订单评论
	else
	  #@info = "您的评论已收到，感谢回复./:share\n"  
	  @info = @weixin_config.text5
	  user = User.find(1)
	  user.replies.create({
	    :name => @weixin.from_user_name,
	    :content => comment
	  })
	end
      else
        #@info = "错误提示:评论不可为空\n"
	#@info << "温馨提示:G开头的任意文字，都自动作为评论"
	@info = @weixin_config.text6
      end
      render template: "weixin/menu"   
    else
      @info = menu_help(@site_config,@weixin_config,@weixin.from_user_name)
      render template: "weixin/menu"
    end

  end


  #主菜单
  def menu_help(site_config,weixin_config,weixin)
    #url_base = "http://fruit.solife.us"
    url_base = site_config.text1.to_s
    url_user = "#{url_base}/customers/join?weixin=#{weixin}"
    url_shop = "#{url_base}/shop?weixin=#{weixin}"
    url_rmd  = "#{url_base}/recommends?weixin=#{weixin}"
    url_news = "#{url_base}/shop/news?weixin=#{weixin}"
    url_send = "#{url_base}/distribution?weixin=#{weixin}"
    url_list = "#{url_base}/list?weixin=#{weixin}"
    #help = "您好,欢迎关注爱果，越先越鲜，回复以下字母开始体验.\n"
    #help << "温馨提示:目前仅为闵行(梅陇镇/莘庄工业区/古美/莘庄镇)提供[爱果]服务.\n"
    help = CGI::unescape(weixin_config.text1)
    help = weixin_config.text1 + "\n"
    help << weixin_config.text7 + "\n"
    help << "A.<a href='#{url_user}'>会员尊享</a>\n"
    help << "B. 今日特惠\n"
    help << "C.<a href='#{url_shop}'>在线订购</a>\n"
    help << "D.<a href='#{url_news}'>预约新品</a>\n"
    help << "E.<a href='#{url_send}'>配送范围</a>\n"
    help << "F.<a href='#{url_list}'>了解更多</a>\n"
    #help << "发表评论请回复: G评论内容"
    help << weixin_config.text2
    puts help
    return help
  end

  #菜单服务
  def menu_service(site_config,weixin_config,weixin,type)
    url = site_config.text1.to_s
    case type
    when "user"
      @info = weixin_config.text8
      url = "#{url}/customers/join?weixin=#{weixin.from_user_name}"
      klass = "详情点击"
    when "shop"
      @info = weixin_config.text9
      url = "#{url}/shop?weixin=#{weixin.from_user_name}"
      klass = "开始选购水果" 
    else
      @info = weixin_config.text9
      url = "#{url}/shop?weixin=#{weixin.from_user_name}"
      klass = "开始选购水果" 
    end

    @info << "<a href='#{url}'>#{klass}</a>"
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
