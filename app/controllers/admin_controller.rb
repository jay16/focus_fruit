class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = Order.all

    @fruit_zones = FruitZone.order("state asc")
    @fruit_zones.first.force_fruit_zone_list
    @fruit_zones.first.force_fruit_zone_state

    @blogs = Blog.all
    @folders = Folder.all
    @shop_carts =ShopCart.all
  end
end
