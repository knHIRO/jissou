Rails.application.routes.draw do
  namespace :public do
    get 'cart/items'
  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'

}
root to: 'public/homes#top'
get 'public' => 'public/homes#top'
resources :homes, only: [:top, :about]
namespace :public do
 resources :items, only: [:index, :show]
 resources :customers, only:[:show, :edit, :confirmation]
 resources :cart_item, only:[:index,]
 resources :orders, only:[:new, :completion, :confirmation, :index, :show]
 resources :address, only:[:index, :edit]
end
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


get 'admin' => 'admin/homes#top'
#root to: 'homes#top'


resources :homes, only: [:top, :about]
namespace :admin do
 resources :items, only: [:index, :new, :show, :edit]
 resources :genres, only: [:index, :edit]
 resources :customers, pnly: [:index, :show, :edit]

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
