class Fruit < ActiveRecord::Base
  attr_accessible :inventory, :name, :price, :state
  attr_accessible :pic
  attr_accessible :desc, :markdown

  has_many :fruit_with_zones
  has_many :fruit_zones, :through => :fruit_with_zones

  has_many :fruit_with_pictures, :dependent => :destroy
  has_many :pictures, :through => :fruit_with_pictures

  def image
    picture = Picture.find(self.pic.to_i)
    folder = picture.folder
    File.join("/pictures",folder.id.to_s,picture.store)
  end

  def link
    "http://fruit.solife.us/fruits/#{self.id}"
  end
end
