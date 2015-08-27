Rails.application.routes.draw do
  root "welcome#index"

  resources :reservations,  only: [:new, :create, :index,  :show]
  namespace :admin do
    resources :users, :listings, :reservations
  end

  post    '/cart',            to: 'carts#create'
  get     '/cart',            to: 'carts#show'
  delete  '/cart',            to: 'carts#destroy'

  resources :listings,      only: [:index,  :show]
  resources :locations,     only: [:index,  :show]
  resources :users,         only: [:new,    :create, :edit,   :update]

  get     '/admin/dashboard', to: 'admin/dashboard#index'
  get     '/profile',         to: 'users#show'

  get     '/login',           to: "sessions#new"
  post    '/login',           to: "sessions#create"
  delete  '/logout',          to: "sessions#destroy", as: "logout"

end
