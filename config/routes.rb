Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  get 'orders', to: 'orders#index'
  get 'categories', to: 'categories#index'
  get 'products', to: 'products#index'
  get 'customers', to: 'customers#index'
  get 'order_items', to: 'order_items#index'
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  get 'home', to: 'home#index'

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
  resources :contacts, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
