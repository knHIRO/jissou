class Admin::OrdersController < ApplicationController
  def show
    @order = Order.new
    @orders = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice]="You have updated user successfully."
      redirect_to admin_order_path(@order.id)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:genre_id, :name, :introduction, :price, :is_active, :profile_image)
  end
end
