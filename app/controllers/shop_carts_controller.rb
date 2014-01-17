class ShopCartsController < ApplicationController
  # GET /shop_carts
  # GET /shop_carts.json
  def index
    @shop_carts = ShopCart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_carts }
    end
  end
  
  def list
    idstr = find_idstr(params)
    list = []
    if (shop_cart = ShopCart.find_by_idstr(idstr))
      list = shop_cart.cart_items
    end

    render :json => list.to_json
  end

  #向购物车添加商品
  def add
    shop_cart = find_shop_cart(params)
    shop_cart.add_item(params)

    render :json => params.to_json
  end

  #向购物车移除商品
  def rm
    shop_cart = find_shop_cart(params)
    shop_cart.rm_item(params)

    render :json => params.to_json
  end

  def clear
    idstr = find_idstr(params)
     if (shop_cart = ShopCart.find_by_idstr(idstr))
       shop_cart.clear
     end

     render :json => params.to_json
  end

  #给该用户分配购物车
  def find_shop_cart(params)
    idstr = find_idstr(params)

    ShopCart.find_or_create_by_idstr(idstr)
  end

  def bkfind_idstr(params)
    if (params[:weixin] || "no") == "no"
      idstr = generate_idstr
    else
      idstr = params[:weixin]
    end
  end

  #为该用户分配标识idstr
  #微信用户直接使用[微信id]
  #其他用户使用:[ip-浏览器]标识
  def bkgenerate_idstr
    user_agent = request.user_agent.downcase
    knowns = ["iphone","ipad","android","firefox","chrome","safari","msie 6.0","msie 7.0","msie 8.0","msie 9.0","msie 10.0","msie","opera","etscape"] 
    #不属于keywords的设置为unknown
    browser = "unknown"
    unless (rts = knowns.select { |k| user_agent.include?(k) }).empty?
      browser = rts[0]  
    end
    
    "#{request.remote_ip}-#{browser}"
  end

  # GET /shop_carts/1
  # GET /shop_carts/1.json
  def show
    @shop_cart = ShopCart.find_by_idstr(params[:idstr])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_cart }
      format.js
    end
  end

  # GET /shop_carts/new
  # GET /shop_carts/new.json
  def new
    @shop_cart = ShopCart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_cart }
    end
  end

  # GET /shop_carts/1/edit
  def edit
    @shop_cart = ShopCart.find(params[:id])
  end

  # POST /shop_carts
  # POST /shop_carts.json
  def create
    @shop_cart = ShopCart.new(shop_cart_params)

    respond_to do |format|
      if @shop_cart.save
        format.html { redirect_to @shop_cart, notice: 'Shop cart was successfully created.' }
        format.json { render json: @shop_cart, status: :created, location: @shop_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_carts/1
  # PATCH/PUT /shop_carts/1.json
  def update
    @shop_cart = ShopCart.find(params[:id])

    respond_to do |format|
      if @shop_cart.update_attributes(shop_cart_params)
        format.html { redirect_to @shop_cart, notice: 'Shop cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_carts/1
  # DELETE /shop_carts/1.json
  def destroy
    @shop_cart = ShopCart.find(params[:id])
    @shop_cart.destroy

    respond_to do |format|
      format.html { redirect_to shop_carts_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def shop_cart_params
      params.require(:shop_cart).permit(:idstr, :session, :weixin)
    end
end
