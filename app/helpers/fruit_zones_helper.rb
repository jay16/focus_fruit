#encoding: utf-8
module FruitZonesHelper


  #购物车中水果数量
  def shop_cart_count(cart_items,fruit)
    count = 0
    unless cart_items.empty? 
     unless ( items = cart_items.select { |i| i["id"] == dom_id(fruit) }).empty?
       item  = items[0]
       count = item["count"].to_i 
       #订单列表中仍需要使用items
       #不可删除
       #cart_items.delete(item)
     end
    end
    return count
  end
end
