Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :products, only: [:index, :show]
  resources :order_items
  resource :carts, only:[:show]

  root to: 'products#index'

end
 