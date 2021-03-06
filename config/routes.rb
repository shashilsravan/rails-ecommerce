Rails.application.routes.draw do
  post '/address', to: 'address#create'
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'
  put '/cart', to: 'cart#update'
  delete '/cartAll', to: 'cart#destroyAll'
  get '/cart/checkout', to: 'cart#checkout'
  get '/cart/placeorder', to: 'cart#order', as: 'order'
  get '/allProducts', to: 'store#all'
  get '/category/:name', to: 'store#category'
  post '/store', to: 'store#filter'
  devise_for :users
  resources :products
  get '/admin/products', to: 'products#all'
  root 'store#index'
  get '/search', to: 'store#search'
  get '/orders', to: 'order#index'
  post '/orders', to: 'order#create'
  get '/orders/all', to: 'order#all'
  get '/orders/myorders/:id', to: 'order#show', as: 'order_details'
  delete '/orders/myorders/:id', to: 'order#destroy'
  post '/orders/myorders/:id/return', to: 'order#return'
  put '/orders/myorders/:id/payment', to: 'order#payment'
  put '/orders/myorders/:id/deliver', to: 'order#delivered'
end
