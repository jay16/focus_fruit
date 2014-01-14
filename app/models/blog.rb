#encoding: utf-8
class Blog < ActiveRecord::Base
  attr_accessible :author, :content, :markdown, :link, :title, :klass

  def mappings
    [
      [["达人说","blog"],1],
      [["配送服务","distribution"],2],
      [["电话客服","call-center"],3],
      [["支付方式","payment"],4],
      [["使用教程","course"],5]
    ]
  end

  #映射为二维数组，
  #在创建taggroup的_form中选择使用
  def type_map
    mappings.map { |d| [d[0][0],d[0][1]] }
  end

  def type
    klass =  mappings.select { |m| m[0][1] == self.klass }
    .first
    if klass 
      klass[0][0]
    else
      "未设置分类"
    end
  end

  def link
    "http://fruit.solife.us/blogs/"+self.id.to_s
  end
end
