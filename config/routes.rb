Rails.application.routes.draw do

  resources :tools
  resources :users, only: [:new, :create, :show]
  root to: 'users#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
