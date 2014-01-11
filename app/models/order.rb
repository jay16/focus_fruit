class Order < ActiveRecord::Base
  attr_accessible :address, :browser, :date_at, :info, :ip
  attr_accessible :name, :phone, :remark, :weixin, :order_list

  has_many :order_with_fruits, :dependent => :destroy
  has_many :fruits, :through => :order_with_fruits
end
