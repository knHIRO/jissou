Rails.application.routes.draw do
  namespace :public do

  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'

}
root to: 'public/homes#top'
get 'public' => 'public/homes#about', as: 'about'
#resources :homes, only: [:top, :about]
get 'public/customers/confirmation' => 'public/customers#confirmation', as: 'customers_confirmation'
post 'public/orders/confirmation' => 'public/orders#confirmation', as: 'orders_confirmation'
get 'public/orders/completion' => 'public/orders#completion',as: 'orders_completion'
patch 'public/customers/exit' => 'public/customers#exit', as: 'customers_exit'
delete 'public/cart_items' => 'public/cart_items#destroy_all', as: 'cart_items_destroy_all'
namespace :public do
 resources :items, only: [:index, :show]
 resource :customers, only:[:show, :edit, :update]
 resources :cart_items, only: [:index, :create, :update, :destroy]
 resources :orders, only:[:new, :index, :show, :create]
 resources :addresses, only:[:index, :edit, :create, :update, :destroy]
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
 resources :items, only: [:index, :new, :show, :edit, :create, :update]
 resources :genres, only: [:index, :edit, :create, :update]
 resources :customers, only: [:index, :show, :edit, :update]
 resources :orders, only: [:show, :update]
 resources :order_details, only: [:update]

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
