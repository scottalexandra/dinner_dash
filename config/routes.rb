Rails.application.routes.draw do

  root "home#index"
  get "/not_found", to: "home#not_found"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :categories, only: [:index, :show]
  resources :items, only: [:index, :show]

  resources :users, only: [:show, :edit, :update, :new] do
    member do
      resources :orders
    end
  end

  namespace :admin do
    resources :categories
    resources :items
  end

end
