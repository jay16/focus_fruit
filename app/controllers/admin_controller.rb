class AdminController < ApplicationController
  def index
    @orders = Order.all
    @fruit_zones = FruitZone.all
    @blogs = Blog.all
  end
end
