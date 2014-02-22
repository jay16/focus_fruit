class Picture < ActiveRecord::Base
  attr_accessible :desc, :folder_id, :name, :store
  #name  图片显示名称
  #store 图片存储名称

  belongs_to :folder

  has_many :fruit_with_pictures, :dependent => :destroy
  has_many :fruits, :through => :fruit_with_pictures

  has_many :blog_with_pictures, :dependent => :destroy
  has_many :blogs, :through => :blog_with_pictures

  def path
    base_path(self.folder.id.to_s)
  end

  def fruit_path
   base_path("fruit") 
  end

  def blog_path
    base_path("blog")
  end

  def base_path(folder)
    File.join("/pictures", folder, self.store)
  end
end


