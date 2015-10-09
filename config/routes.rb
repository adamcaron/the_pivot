Rails.application.routes.draw do
  root "welcome#index"

  resources :reservations,  only: [:new, :create, :index,  :show]

  resources :listings
  resources :locations,       only: [:index, :show]
  resources :users

  get     '/search_results',  to: 'listings#search_results'
  get     '/dashboard',       to: 'users#show'

  get     '/login',           to: "sessions#new"
  post    '/login',           to: "sessions#create"
  delete  '/logout',          to: "sessions#destroy", as: "logout"

end
