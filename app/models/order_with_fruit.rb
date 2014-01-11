class OrderWithFruit < ActiveRecord::Base
  attr_accessible :fruit_id, :order_id

  belongs_to :fruit
  belongs_to :order
end
