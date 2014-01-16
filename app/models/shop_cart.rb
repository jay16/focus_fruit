class ShopCart < ActiveRecord::Base
  attr_accessible :idstr, :session

  #购物车内容
  #为顾客使用
  def cart_items
    JSON.parse((self.session || "[]").gsub("=>",":"))
  end
 

  def cart_items_size
    size = 0
    #unless cart_items.empty?
      #cart_items.each do |f|
      #  size += f["count"].to_i
      #end
    #end
    return size
  end

  def cart_items_price
    price = 0
    #if not cart_items.empty?
    #  cart_items.each do |f|
    #    price += f["count"].to_i * f["price"].to_f
    #  end
    #end
    return price
  end

  #清空购物车
  def clear
    self.update_attribute(:session, "")
  end

  #向购物车添加商品
  def add_item(params)
    operate_item(params,"add")
  end

  #向购物车删除商品
  def rm_item(params)
    operate_item(params,"rm")
  end

  #操作购物车
  def operate_item(params, operation)
    #当前顾客选中的商品
    item = params[:item]

    #查看购物车中是已有
    items = JSON.parse((self.session || "[]").gsub("=>",":"))
    rts = items.select { |i| i["id"] == item["id"] }

    #存在则取值, 不存在则赋值
    #从购物车中删除该商品操作完成后再放入
    if not items.empty? and not rts.empty?
      my_session = rts[0]
      items.delete(rts[0])
    else
      my_session = item.merge({"count" => 0})
    end

    #操作商品的数量
    if operation == "add"
      my_session["count"] = (my_session["count"] || 0).to_i + 1
    else
      my_session["count"] = (my_session["count"] || 0).to_i - 1
      my_session["count"] = 0 if my_session["count"] < 0
    end

    #放回购物车
    self.update_attribute(:session, items.push(my_session).to_s)
  end

end
