#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :name, :phone, :address, :date_at, :remark, :count, :checkout, :state
  attr_accessible :weixin, :item_list, :info, :ip, :browser

  has_many :items, :dependent => :destroy
  has_many :order_with_customers
  has_many :customers, :through => :order_with_customers

  after_create :force_order_state_present
  after_create :build_order_with_customer
  after_create :build_order_with_fruits

  #配送时间
  def date_at_list
    ["10:00-10:30",
     "11:30-12:00",
     "16:00-16:30",
     "20:00-21:00"]
  end

  #创建订单&商品关联
  def build_order_with_fruits
    jsons = JSON.parse(self.item_list)
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

  #创建订单&顾客关联
  def build_order_with_customer
    if (customers = Customer.where("idstr='#{self.weixin}' and phone='#{self.phone}' and address='#{self.address}'")).length > 0
       customer = customers.order("created_at desc").first
       OrderWithCustomer.create({
	 :order_id    => self.id,
	 :customer_id => customer.id
       })
    else
      self.customers.create({
	:idstr => self.weixin,
	:name  => self.name,
	:phone => self.phone,
	:address => self.address
      })
    end
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
