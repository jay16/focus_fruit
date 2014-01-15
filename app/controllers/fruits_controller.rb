#encoding: utf-8
class FruitsController < ApplicationController
  before_filter :find_fruit, :only => [:show, :edit, :update, :destroy]

  def index
    @fruits = Fruit.all
  end

  def show
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
end
