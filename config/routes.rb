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
namespace :public do
 resources :items, only: [:index, :show]
 resource :customers, only:[:show, :edit, :confirmation]
 resources :cart_items, only: [:index, :show]
 resources :orders, only:[:new, :completion, :confirmation, :index, :show]
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
