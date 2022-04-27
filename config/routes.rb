Rails.application.routes.draw do
  get 'carts/show'
  devise_for :users

  resources :products
  resources :shops, only: [:index, :show]
  resources :order_items
  resource :carts, only:[:show]

  root to: 'shops#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 