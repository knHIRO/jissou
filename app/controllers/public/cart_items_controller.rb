class Public::CartItemsController < ApplicationController
  def index
    #@cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @tortal = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items = current_customer.cart_items

    if @cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_items.find_by(item_id: params[:cart_item][:item_id]).update(amount: @cart_items.find_by(item_id: params[:cart_item][:item_id]).amount.to_i + @cart_item.amount.to_i)
    else
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
    redirect_to public_cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      #flash[:notice]="You have updated customer successfully."
      redirect_to public_cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end
  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
