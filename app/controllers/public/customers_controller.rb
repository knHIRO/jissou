class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.new
    @customers = Customer.all

  end

  def edit
    @customer = Customer.new
  end

  def confirmation

  end

  def exit
    redirect_to '/'

  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice]="You have updated user successfully."
      redirect_to public_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
