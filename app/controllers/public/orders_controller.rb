class Public::OrdersController < ApplicationController
  def index
    @order = Order.new
    @orders = Order.all
  end

  def show
    @order = Order.new
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @order = Order.new(order_params)

    #@book.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @order.save
    # 4. トップ画面へリダイレクト
    flash[:notice]="You have created book successfully."

    redirect_to public_order_path(@order.id)
    else
    @orders = Order.all
    #@user = current_user
    render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :status, :postage, :created_at, :updated_at)
  end
end
