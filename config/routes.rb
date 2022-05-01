Rails.application.routes.draw do
  get 'payments/new'
  get 'checkouts/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :order_items
  resource :carts, only:[:show] 

  resources :checkouts, only:[:index, :show, :create] do
      resource :payments, only:[:new]
  end
end
 