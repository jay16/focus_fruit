#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_site_config
  before_filter :find_idstr

  #购物车相关
  ##########################################
  #顾客购物车标识
  def find_idstr
    if (params[:weixin] || "no") == "no"
      idstr = generate_idstr
    else
      idstr = params[:weixin]
    end
    @global_customer_idstr = idstr
  end

  #为该用户分配标识idstr
  #微信用户直接使用[微信id]
  #其他用户使用:[ip-浏览器]标识
  def generate_idstr
    user_agent = request.user_agent.downcase
    knowns = ["iphone","ipad","android","firefox","chrome","safari","msie 6.0","msie 7.0","msie 8.0","msie 9.0","msie 10.0","msie","opera","etscape"]
    #不属于keywords的设置为unknown
    browser = "unknown"
    unless (rts = knowns.select { |k| user_agent.include?(k) }).empty?
      browser = rts[0]
    end

    "#{request.remote_ip}-#{browser}"
  end
  ##########################################

  #网站配置
  #########################################
  def find_site_config
    @global_config = SiteConfig.find_or_create_by_name("网站配置")
  end
  #########################################
end
