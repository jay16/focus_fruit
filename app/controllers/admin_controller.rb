class AdminController < ApplicationController
  def index
    @orders = Order.all
    @fruit_zones = FruitZone.all
  end
end
