Rails.application.routes.draw do
  get "home/index"
  get "map/index"
  resource :session
  resources :passwords, param: :token
  resources :products
  resources :users, param: :name

  constraints subdomain: /.+/ do
    get "/", to: "users#show", as: :user_subdomain
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "home#index"
end
