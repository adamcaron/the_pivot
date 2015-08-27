Rails.application.routes.draw do
  root "welcome#index"

  namespace   :admin do
    resources :users, :listings, :reservations
  end

  resources :carts, only: [:create, :destroy] do
    member do
      post :increment, :decrement
    end
  end

  resources :users,         only: [:new, :create, :edit, :update]
  resources :listings,      only: [:index, :show]
  resources :locations,     only: [:index, :show]
  resources :reservations,  only: [:new, :create, :index, :show]
  resources :reviews

  get     '/admin/dashboard', to: 'admin/dashboard#index'

  get     '/profile',         to: 'users#show'

  get     '/cart',            to: 'carts#show'
  post    '/cart',            to: 'carts#create'
  delete  '/cart',            to: 'carts#destroy'

  get     '/login',           to: "sessions#new"
  post    '/login',           to: "sessions#create"
  delete  '/logout',          to: "sessions#destroy", as: "logout"

end
