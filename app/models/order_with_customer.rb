class OrderWithCustomer < ActiveRecord::Base
  attr_accessible :customer_id, :order_id

  belongs_to :order
  belongs_to :customer
end
