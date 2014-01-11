class Order < ActiveRecord::Base
  attr_accessible :name, :phone, :address, :date_at, :remark, :count, :checkout
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
end
