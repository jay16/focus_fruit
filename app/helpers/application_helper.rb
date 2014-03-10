#encoding: utf-8
module ApplicationHelper

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  def page_title(config, params)
    config.text2 + 
    case params[:controller]
    when "customers"
      case params[:action]
      when "join"
        "-会员尊享"
      else
        ""
      end
    when "admin"
      "-管理台"
    when "fruit_zones"
      case params[:action]
      when "index"
	"-在线订购" 
      when "news"
        "-预约新品"
      else 
        ""
      end
    when "blogs"
      case params[:action]
      when "distribution"
        "-配送范围"
      when "list"
        "-了解更多"
      else
        ""
      end
    else
      ""
    end
  end
end
