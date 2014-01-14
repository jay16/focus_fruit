#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :name, :phone, :address, :date_at, :remark, :count, :checkout, :state
  attr_accessible :weixin, :order_list, :info, :ip, :browser

  has_many :items, :dependent => :destroy

  def build_order_with_fruits(jsons)
    jsons.each do |json|
      self.items.create({
        :order_id => self.id,
	:fruit_id => json["id"],
	:name     => json["name"],
	:count    => json["count"],
	:price    => json["price"],
      })
    end if jsons
  end

  def mappings
    [
      [["待发送","wait-send"],1],
      [["已发送","on-send"],2],
      [["已接收","over-send"],3]
    ]
  end

  #映射为二维数组，
  #在创建taggroup的_form中选择使用
  def state_map
    mappings.map { |d| [d[0][0],d[0][1]] }
  end

  def status
    klass =  mappings.select { |m| m[0][1] == self.state }
    .first
    if klass
      klass[0][0]
    else
      "未设置"
    end
  end
end
