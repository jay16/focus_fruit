class Folder < ActiveRecord::Base
  attr_accessible :desc, :name

  has_many :pictures
end
