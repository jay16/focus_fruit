class UserWithReply < ActiveRecord::Base
  attr_accessible :reply_id, :user_id

  belongs_to :user
  belongs_to :reply
end
