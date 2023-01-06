class Admin::ItemsController < ApplicationController

  def index
    @item = Item.new
    @items = Item.page(params[:page])
    @genres = Genre.all
  end
  def new
    @item = Item.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @item= Item.new(item_params)

    #@item.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @item.save
    # 4. トップ画面へリダイレクト
    #flash[:notice]="You have created book successfully."

    redirect_to admin_item_path(@item.id)
    else
    @items = Item.all
    #@user = current_user
    render :new
    end
  end

  def show
    #@item = Item.new
    @item = Item.find(params[:id])
  end

  def edit
   @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      #flash[:notice]="You have updated user successfully."
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :profile_image)
  end
end
