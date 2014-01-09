class FruitWithZone < ActiveRecord::Base
  attr_accessible :fruit_id, :fruit_zone_id

  belongs_to :fruit
  belongs_to :fruit_zone
end
