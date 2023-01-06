class Public::HomesController < ApplicationController
  def top
    @address = Address.new
    @addresses = Address.all
    @genres = Genre.all
    @items = Item.order('id DESC').limit(4)
  end

  def about

  end
end
