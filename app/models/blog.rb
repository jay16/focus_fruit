class Blog < ActiveRecord::Base
  attr_accessible :author, :content, :markdown, :link, :title, :type
end
