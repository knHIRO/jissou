class Public::AddressesController < ApplicationController
   def index
    @address = Address.new
    @addresses = Address.all

   end

   def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @address= Address.new(address_params)

    @address.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @address.save
    # 4. トップ画面へリダイレクト
    flash[:notice]="You have created book successfully."

    redirect_to public_addresses_path
    else
    @addresses = Address.all
    #@user = current_user
    render :index
    end
   end

  def edit
    @address = Address.new
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice]="You have updated user successfully."
      redirect_to public_addresses_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
