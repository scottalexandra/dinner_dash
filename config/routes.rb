Rails.application.routes.draw do

  root "home#index"
  get "/not_found", to: "home#not_found"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/carts", to: "carts#create"
  delete "/carts", to: "carts#destroy"
  get "/admin/filtered_orders", to: "admin/orders#filtered_orders"

  resources :categories, only: [:index, :show]
  resources :items, only: [:show]

  resources :users
  resources :orders

  resources :admins

  namespace :admin do
    resources :categories, only: [:edit, :update, :create, :new, :destroy]
    resources :items
    resources :orders
  end
end
