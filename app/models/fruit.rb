class Fruit < ActiveRecord::Base
  attr_accessible :inventory, :name, :price, :state
  attr_accessible :pic, :link
  attr_accessible :desc, :markdown

  has_many :fruit_with_zones, :dependent => :destroy
  has_many :fruit_zones, :through => :fruit_with_zones
end
