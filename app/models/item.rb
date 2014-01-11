class Item < ActiveRecord::Base
  attr_accessible :order_id, :fruit_id
  attr_accessible :name, :count, :price

  belongs_to :order
end
