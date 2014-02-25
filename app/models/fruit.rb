#encoding: utf-8
class Fruit < ActiveRecord::Base
  attr_accessible :inventory, :name, :price, :unit, :state
  attr_accessible :pic
  attr_accessible :desc, :markdown

  has_many :fruit_with_zones
  has_many :fruit_zones, :through => :fruit_with_zones

  has_many :fruit_with_pictures, :dependent => :destroy
  has_many :pictures, :through => :fruit_with_pictures

  has_many :fruit_with_replies, :dependent => :destroy
  has_many :replies, :through => :fruit_with_replies

  #微信新闻消息显示的图片
  #每个水果有多张展示图片
  #手工可以设置了微信展示图片
  #pid 存放图片id
  def weixin_image
    config = SiteConfig.find(1)
    if self.pictures.size > 0
      if self.pic and picture = Picture.find(self.pic.to_i)
        @picture = Picture.find(self.pic.to_i) 
      else
	@picture = self.pictures.first
      end
      @picture = File.join(config.text1,"/pictures/fruit",@picture.store)
    else
      #没有水果展示图片
      @picture = "http://img0.bdstatic.com/static/common/widget/search_box_search/logo/logo_3b6de4c.png"
    end
    return @picture
  end


  #微信新闻消息显介绍水果的链接
  def link
    config = SiteConfig.find(1)
    return "#{config.text1}/fruits/#{self.id}"
  end

  def fruit_state
    [["预约新品","new"],
     ["今日特惠","recommand"]
    ]
  end

  def chk_state
    state, label = false, ""
    if %w(recommand new).include?(self.state)
       state = true
       label = self.state == "new" ? "预约新品" : "今日特惠"
    end
    return [state, label]
  end

  def state_label
    case self.state
    when "new"
      "[预约新品]"
    when "recommand"
      "[今日特惠]"
    end
  end
end
