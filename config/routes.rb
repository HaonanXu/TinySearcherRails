Rails.application.routes.draw do

  get 'user_activities_controller/show'

  get 'search/index'
  get 'search/show'

  get 'register', to: 'users#new', as: 'new_user'
  post 'register', to: 'users#create', as: 'create_user'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions

  root 'search#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
