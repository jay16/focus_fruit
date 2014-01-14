#encoding: utf-8
class FruitZone < ActiveRecord::Base
  attr_accessible :desc, :name, :state, :list
  #:list => weixin菜单列表序号

  has_many :fruit_with_zones, :dependent => :destroy
  has_many :fruits, :through => :fruit_with_zones

  def mappings
    [
      ["在售","onsale"],
      ["下架","saleout"]
    ]
  end

  #映射为二维数组，
  def state_map
    mappings.map { |d| [d[0],d[1]] }
  end

  def list_map
    fruit_zones = FruitZone.where("state='onsale'").order("list asc")
    fruit_zones.map { |z| [z.list, z.list] } 
  end

  def onsale?
    self.state == "onsale"
  end

  def status
    if klass =  mappings.select { |m| m[1] == self.state }.first
      klass[0][0]
    else
      "未设置"
    end
  end 

  #强制fruit-zone的序号存在且唯一，
  #否则微信菜单有误
  def force_fruit_zone_list
    fruit_zones = FruitZone.where("state='onsale'").order("list asc")
    fruit_zones.each_with_index do |zone, index|
      list = index + 1
      if zone.list and zone.list == list
        #its ok
      else
        zone.update_attribute(:list, list)
      end
    end if fruit_zones
  end

  #强制每个水果专区都有一个状态
  #onsale/saleout
  #不存在则默认设置为onsale
  def force_fruit_zone_state
    fruit_zones = FruitZone.where("state is null or state=''")
    fruit_zones.each_with_index do |zone, index|
      zone.update_attribute(:state, "onsale") 
    end if fruit_zones
  end
end
