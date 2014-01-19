class Customer < ActiveRecord::Base
  attr_accessible :idstr, :name, :phone, :address
  attr_accessible :text1, :text2, :text3, :text4, :text5

  has_many :order_with_customers
  has_many :orders, :through => :order_with_customers
end
