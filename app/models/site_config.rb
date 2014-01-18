class SiteConfig < ActiveRecord::Base
  attr_accessible :name, :text1, :text2, :text3, :text4, :text5, :text6, :text7, :text8, :text9
  validates :name, presence: true, uniqueness: true

  #一、网站配置
  #name:  网站配置
  #text1: 域名网址
  #text2: 网站标题
  #text3: 管理员
  #text4: 管理员邮箱
  #text5: 网站描述

  #二、页签管理
  #name:  页签管理 
  #text1: 用户管理
  #text2: 订单管理
  #text3: 水果专区管理
  #text4: 水果管理
  #text5: 博文管理
  #text6: 图片管理
  #text8: 购物车管理
  #text9: 网站配置
end
