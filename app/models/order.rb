#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :name, :phone, :address, :date_at, :remark, :count, :checkout, :state
  attr_accessible :weixin, :order_list, :info, :ip, :browser

  has_many :items, :dependent => :destroy

  after_create :force_order_state_present

  def build_order_with_fruits(jsons)
    jsons.delete_if { |json| json["count"].to_i <=0 }

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
      [["待发货","wait-send"],1],
      [["已发货","on-send"],2],
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

  #订单必须设置状态，默认: 待发货
  def force_order_state_present
    if self.state.nil? or self.state.empty?
      self.update_attribute(:state, "wait-send")
    end
  end
end
