class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:Item).permit(:image, :name, :explanation, :category_id, :condition_id, :charge_id, :area_id, :days_of_ship_id, :price, )
  end
end
