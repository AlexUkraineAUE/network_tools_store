Rails.application.routes.draw do
  devise_for :customers
  resources :customers

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'

  get 'users/user_page'
  get 'users/sign_up'
  get 'users/login'
  get 'sign_up/login'
  get 'products/search'
  get 'orders', to: 'orders#index'
  get 'categories', to: 'categories#index'
  get 'products', to: 'products#index'
  get 'customers', to: 'customers#index'
  get 'order_items', to: 'order_items#index'
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  get 'home', to: 'home#index'
  get 'cart', to: 'cart#show'
  get 'checkout', to: 'checkout#new'

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

  resources :cart, only: [:show, :create, :update, :destroy]
  delete '/cart/:id', to: 'cart#destroy', as: 'delete_from_cart'
  patch '/cart/:id', to: 'cart#update', as: 'update_cart'
  post '/checkout/contact', to: 'cart#checkout_contact', as: 'checkout_contact'

  unless Rails.application.routes.named_routes[:new_user]
    get 'checkout/new_user', to: 'checkout#new_user', as: 'new_user'
  end

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"

  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
