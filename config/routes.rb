Rails.application.routes.draw do

  resources :tools
  resources :users, only: [:new, :create, :show]
  resources :categories, only: [:index, :show]
  root to: 'users#index'

  namespace "admin" do
    resources :categories
    resources :tools
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
