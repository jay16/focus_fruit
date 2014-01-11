class Fruit < ActiveRecord::Base
  attr_accessible :desc, :inventory, :name, :price, :state

  has_many :fruit_with_zones, :dependent => :destroy
  has_many :fruit_zones, :through => :fruit_with_zones


    has_many :order_with_fruits, :dependent => :destroy
    has_many :orders, :through => :order_with_fruits
end
