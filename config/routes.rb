Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  root "games#index"

  resources :critics
  resources :involved_companies
  resources :games do
    resources :critics

    # /games/:id/add_genre
    post "add_genre", on: :member
    # /games/:id/remove_genre
    delete "remove_genre", on: :member

    # /games/:id/add_platform
    post "add_platform", on: :member
    # /games/:id/remove_platform
    delete "remove_platform", on: :member
  end
  resources :platforms
  resources :genres
  resources :companies do
    resources :critics
  end
  resources :users
  post "/users-admin", to: "users#create_user" # to handle user creation from admin
  patch "/users-admin/:id", to: "users#update_user", as: "user_admin" # to handle user update from admin

  # Routes for Codeable Design
  get "/design", to: "design#index"
  get "/design/sections", to: "design#sections"
end
