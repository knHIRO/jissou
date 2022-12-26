class Public::HomesController < ApplicationController
  def top
    @address = Address.new
    @addresses = Address.all
    @genres = Genre.all
  end

  def about

  end
end
