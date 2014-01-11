class OrdersController < ApplicationController

  before_filter :find_order, :only => [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def new
  end

  def create
    @order = Order.create(params[:order].merge({
      :ip      => request.remote_ip,
      :browser => request.user_agent
    }))
    @order.build_order_with_fruits(JSON.parse(params[:order_list]))

  end

  def show; end
  def edit; end

  def update
    @order.update_attributes(params[:order])
  end

  def destroy
    @order.destroy
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
