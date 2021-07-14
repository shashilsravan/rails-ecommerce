Rails.application.routes.draw do
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'
  put '/cart', to: 'cart#update'
  devise_for :users
  resources :products
  get '/admin/products', to: 'products#all'
  root 'store#index'
  get '/search', to: 'store#search'
end
