class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders

  end

  def show
    @order = Order.new
    @orders = Order.all
  end

  def completion

  end

  def confirmation
    @order = Order.new(order_params)
    @orders = current_customer.orders
    @cart_items = current_customer.cart_items
    @total = 0
    @order.postage = 800
    if params[:order][:select_address] == "0" # ご自身の住所 選択時
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1" # 登録済住所から選択 選択時
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2" # 新しいお届け先 選択時
    end

  end

  def new
    @order = Order.new
    @customers = current_customer
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @order.save

      #ログインしているカートアイテムをまとめて取得
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
      #カートアイテムをeach文でオーダーディティールに情報を保存

      #カートアイテムを削除
    current_customer.cart_items.destroy_all
    # 4. トップ画面へリダイレクト
    flash[:notice]="You have created book successfully."

    redirect_to orders_completion_path(@order.id)
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
