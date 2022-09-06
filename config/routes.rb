Rails.application.routes.draw do

  root to: "public/homes#top"
  get "about" => "public/homes#about"


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  namespace :customers do
    resources :items, only: [:index, :show]
  end


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
