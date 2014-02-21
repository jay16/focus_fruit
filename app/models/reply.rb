class Reply < ActiveRecord::Base
  attr_accessible :content, :email, :markdown, :name

  has_many :fruit_with_replies, :dependent => :destroy
  has_many :fruits, :through => :fruit_with_replies
end
