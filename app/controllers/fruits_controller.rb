class FruitsController < ApplicationController
  before_filter :find_fruit, :only => [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @fruit.destroy
  end

  private

  def find_fruit
    @fruit_zone = FruitZone.find(params[:fruit_zone_id])
    @fruit = Fruit.find(params[:id])
  end
end
