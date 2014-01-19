class OrdersController < ApplicationController
  before_filter :find_order, :only => [:show, :edit, :state, :update, :destroy]

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

    #提交订单后清空购物车
    if @order.save
      idstr = @global_customer_idstr
      if (shop_cart = ShopCart.find_by_idstr(idstr))
	shop_cart.clear
      end
    end
  end


  def show; end

  def edit; end
  
  #调整订单状态
  def state
    @order.update_attributes(params[:order]) 
  end

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
