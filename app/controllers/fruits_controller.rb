#encoding: utf-8
class FruitsController < ApplicationController
  before_filter :find_fruit, :only => [:show, :state, :images, :upload, :edit, :update, :destroy]

  def index
    @fruits = Fruit.all
  end

  def show
    #顾客购物车
    #已经选购商品/商品数量/商品总值
    @shop_cart = {
      :items => [],
      :count => 0,
      :price => 0
    }
    if (shop_cart = ShopCart.find_by_idstr(@global_customer_idstr))
        @shop_cart[:items] = shop_cart.cart_items
        @shop_cart[:count] = shop_cart.cart_items_count
        @shop_cart[:price] = shop_cart.cart_items_price
    end
  end

  def state
    @fruit.update_attributes(params[:fruit])
  end

  def images
    @pictures =  @fruit.pictures

    respond_to do |format|
      format.html { render layout: "layouts/application" }
    end
  end

  def upload
    deal_with_local(@fruit)
  end

  def new
  end

  def create
    @folder = Folder.find_by_name("水果图片")
  end

  def edit
    @folder = Folder.find_by_name("水果图片")
  end

  def update
    respond_to do |format|
      if @fruit.update_attributes(fruit_params)
        format.html { redirect_to @fruit, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fruit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fruit.destroy
  end

  def remove
  end

  private

  def find_fruit
    #@fruit_zone = FruitZone.find(params[:fruit_zone_id])
    @fruit = Fruit.find(params[:id])
  end

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def fruit_params
    params.require(:fruit).permit(:inventory, :name, :price, :state, :desc, :markdown, :pic, :link)
  end

  def deal_with_local(fruit)
    (0..50).each_with_index do |i,index|
      key = "file_#{i}"
      next if params[key].nil?

      image = params[key]

      original_name = image.original_filename.to_s
      image_name   = chk_image_name(original_name)
      image_path = Rails.root.join("public","pictures","fruit")

      FileUtils.mkdir_p(image_path) unless File.exist?(image_path)

      image_path = File.join(image_path, image_name)
      File.open(image_path, "wb") { |f| f.write(image.read) }

      picture = fruit.pictures.create({
       :name => original_name,
       :desc => original_name,
       :store => image_name
       })
    end
  end
  def chk_image_name(str)
    types = %w(.jpg .jpeg .png .bmp .gif .ico).select { |d| str.downcase.include?(d) }
    type = (types.empty? ? ".jpg" : types[0])

    name = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, str+Time.now.to_s).to_s
    return (name+type)
  end
end
