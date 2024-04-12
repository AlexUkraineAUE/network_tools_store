Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'order_items/index'
  get 'order_items/show'
  get 'orders/index'
  get 'orders/show'
  get 'categories/index'
  get 'categories/show'
  get 'products/index'
  get 'products/show'
  get 'customers/index'
  get 'customers/show'


  get 'orders', to: 'orders#index'
  get 'categories', to: 'categories#index'
  get 'products', to: 'products#index'
  get 'customers', to: 'customers#index'
  get 'order_items', to: 'order_items#index'

  resources :orders, only: [:index, :show] do
    collection do
      get "search"
    end
  end
  resources :categories, only: [:index, :show]
  resources :order_items, only: [:index, :show]
  resources :products, only: [:index, :show] do
    collection do
      get "search"
    end
  end
  resources :customers, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
