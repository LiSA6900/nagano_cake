Rails.application.routes.draw do

  root to: "public/homes#top"
  get "about" => "public/homes#about"


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    # 退会確認画面
    get "customers/unsubscribe" => "customers#unsubscribe"
    # 論理削除用のルーティング
    patch "customers/withdraw" => "customers#withdraw"

    resources :items, only: [:index, :show]

    resources :addresses, only: [:index, :create, :update, :destroy, :edit]

    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :show]

    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    resources :orders, only: [:new, :index, :create, :show]
  end



  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get "/" => "homes#top"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
