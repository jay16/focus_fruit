class BlogWithPicture < ActiveRecord::Base
  attr_accessible :blog_id, :picture_id

  belongs_to :blog
  belongs_to :picture
end
