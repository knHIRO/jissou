class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
   # @order_deta
     # @total = 0
    # @order_details.each do |order_detail|
    # @total += order_detail.subtotal
    # end
    @total = @order_details.sum(&:subtotal)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status:params[:order][:status].to_i)

      redirect_to admin_order_path(@order.id)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :status, :postage, :created_at, :updated_at)
    #params.require(:order).permit(:genre_id, :name, :introduction, :price, :is_active, :profile_image)
  end
end
