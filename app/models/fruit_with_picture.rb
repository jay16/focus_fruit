class FruitWithPicture < ActiveRecord::Base
  attr_accessible :fruit_id, :picture_id

  belongs_to :fruit
  belongs_to :picture
end
