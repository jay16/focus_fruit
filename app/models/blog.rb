#encoding: utf-8
class Blog < ActiveRecord::Base
  attr_accessible :author, :content, :markdown, :link, :title, :klass

  has_many :blog_with_pictures, :dependent => :destroy
  has_many :pictures, :through => :blog_with_pictures

  def mappings
    [
      [["达人说","blog"],1],
      [["爱果服务","service"],2],
      [["配送范围","distribution"],3],
      [["使用教程","course"],4]
    ]
  end

  #映射为二维数组，
  #在创建taggroup的_form中选择使用
  def type_map
    mappings.map { |d| [d[0][0],d[0][1]] }
  end

  def type
    klass =  mappings.select { |m| m[0][1] == self.klass }
    .first
    if klass 
      klass[0][0]
    else
      "未设置分类"
    end
  end


  #微信新闻消息显示的图片
  #每个水果有多张展示图片
  #手工可以设置了微信展示图片
  #pid 存放图片id
  def weixin_image
    config = SiteConfig.find(1)
    if self.pictures.size > 0
      @picture = self.pictures.first
      @picture = File.join(config.text1,"/pictures/blog",@picture.store)
    else
      #没有水果展示图片
      @picture = "http://img0.bdstatic.com/static/common/widget/search_box_search/logo/logo_3b6de4c.png"
    end
    return @picture
  end


  #微信新闻消息显介绍水果的链接
  def link
    config = SiteConfig.find(1)
    return "#{config.text1}/blogs/#{self.id}"
  end

end
