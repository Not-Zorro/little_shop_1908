Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/cart', to: 'cart#index'
  get '/cart/checkout', to: 'order#index'
  get '/order/:order_id', to: 'order#show'
  post '/cart/order/submit', to: 'order#create'
  delete '/cart/empty', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#delete_item'
  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"
  patch "/cart/:item_id/:type", to: "cart#update_item"
  patch "/cart/:item_id", to: "cart#update"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  patch "/items/:item_id/reviews/:review_id", to: 'reviews#update'
  get "/items/:item_id/reviews/:review_id/edit", to: "reviews#edit"
  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  post "/items/:item_id", to: "reviews#create"
  delete "/items/:id", to: "items#destroy"
  delete "/items/:item_id/reviews/:review_id/delete", to: "reviews#destroy"
end
