class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.new
    @items = Item.find(params[:id])
    @genres = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :profile_image)
  end
end
