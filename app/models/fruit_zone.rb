class FruitZone < ActiveRecord::Base
  attr_accessible :desc, :name, :state

  has_many :fruit_with_zones, :dependent => :destroy
  has_many :fruits, :through => :fruit_with_zones
end
