class FruitWithReply < ActiveRecord::Base
  attr_accessible :fruit_id, :reply_id

  belongs_to :fruit
  belongs_to :reply
end
