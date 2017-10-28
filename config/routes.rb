Rails.application.routes.draw do

  get 'search/index'
  get 'search/show'
  get 'register', to: 'user#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions

  root 'search#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
