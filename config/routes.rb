Rails.application.routes.draw do
  get "explore", to: "home#explore", as: :explore
  get "info", to: "home#info", as: :info
  get "imprint", to: "home#imprint", as: :imprint
  resource :session
  resources :passwords, param: :token
  resources :products, except: :index
  get "products/:id/delete", to: "products#delete", as: :delete_product
  resources :users, param: :name

  get "messages", to: "message_threads#index", as: :message_threads
  get "messages/:id", to: "message_threads#show", as: :message_thread
  post "messages", to: "message_threads#create_with_message_and_product", as: :create_message_thread_with_message_and_product

  get "cart", to: "cart#index", as: :cart
  get "cart/products", to: "cart#products", as: :cart_products

  constraints subdomain: /.+/ do
    get "/", to: "users#show", as: :user_subdomain
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "home#index"
end
