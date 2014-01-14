#encoding: utf-8
class FruitZone < ActiveRecord::Base
  attr_accessible :desc, :name, :state, :list
  #:list => weixin菜单列表序号

  has_many :fruit_with_zones, :dependent => :destroy
  has_many :fruits, :through => :fruit_with_zones

  def mappings
    [
      [["在售","onsale"],1],
      [["下架","saleout"],2]
    ]
  end

  #映射为二维数组，
  #在创建taggroup的_form中选择使用
  def type_map
    mappings.map { |d| [d[0][0],d[0][1]] }
  end

  def status
    klass =  mappings.select { |m| m[0][1] == self.state }
    .first
    if klass
      klass[0][0]
    else
      "未设置"
    end
  end 
end
