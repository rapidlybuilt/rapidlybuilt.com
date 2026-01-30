Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "search", to: "searches#show"

  # only static because we're pre-rendering in production
  get "api/search", to: "rapidly_built/api/searches#static", as: :search_api

  namespace :apps do
    root to: "pages#index"
    get "rapidlybuilt.com", to: "pages#rapidlybuilt_com", as: :rapidlybuilt_com
  end

  namespace :tools do
    root to: "pages#index"

    get "baking-rack", to: "pages#baking_rack", as: :baking_rack
    get "rapidly-built", to: "pages#rapidly_built", as: :rapidly_built

    mount UiDocs::Engine => "rapid-ui", as: :rapid_ui
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "403", to: "pages#forbidden", as: :forbidden
  get "404", to: "pages#not_found", as: :not_found
  get "500", to: "pages#internal_server_error", as: :system_error

  root "pages#home"
end
