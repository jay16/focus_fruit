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
    if content == "1.1"
      @info = menu_shop(@weixin)
    else
      @info = menu_help
    end
  end

  def menu_shop(weixin)
    info = "健康生活-水果达人为您服务,请"
    url = "http://fruit.solife.us?weixin=#{weixin.from_user_name}"
    info << "<a href='#{url}'>点击此处开始选购水果</a>"
  end

  def menu_help
    help = "您好，欢迎光临[水果达人]，请回复数字选择服务:\n\n"
    help << "水果信息\n" 
    help << " 1.1 达人专属\n"
    help << " 1.2 优惠专区\n"
    help << " 1.3 水果便当\n"
    help << " 1.4 鲜果礼盒\n"
    help << "达人服务\n" 
    help << " 2.2.在线订购\n"
    help << " 2.2 配送服务\n"
    help << " 2.3 支付方式\n"
    help << " 2.4 电话客服\n"
    help << "我的生活\n" 
    help << " 3.1 订单查询\n"
    help << " 3.2 达人心情\n"

    help << "\n回复[?]显示此帮助菜单\n"
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
end
