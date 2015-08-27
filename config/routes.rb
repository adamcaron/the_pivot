Rails.application.routes.draw do
  root "welcome#index"

  namespace :admin do
    resources :users, :listings, :reservations
  end

  get '/admin/dashboard', to: 'admin/dashboard#index'

  resources :users, only: [:new, :create, :edit, :update]

  get '/profile', to: 'users#show'

  resources :listings, only: [:index, :show]

  resources :locations, only: [:index, :show]

  post '/cart', to: 'carts#create'

  resources :carts, only: [:create, :destroy] do
    member do
      post :increment, :decrement
    end
  end

  resources :reviews

  get '/cart', to: 'carts#show'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy", as: "logout"
  delete '/cart', to: 'carts#destroy'

  resources :reservations, only: [:new, :create, :index, :show]
end
