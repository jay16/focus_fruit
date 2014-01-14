class Picture < ActiveRecord::Base
  attr_accessible :desc, :folder_id, :name, :store

  belongs_to :folder
end
