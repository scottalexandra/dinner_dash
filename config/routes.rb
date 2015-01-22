Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root "home#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  resources :categories, :items, :users
end
