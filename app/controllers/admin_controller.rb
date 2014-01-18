#encoding: utf-8
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


    @nav_tab_config = SiteConfig.find_or_create_by_name("页签管理")
  end
end
