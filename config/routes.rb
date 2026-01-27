Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :tools, defaults: { app_id: "tools" } do
    root to: "pages#index"
    get "search", to: "searches#show"

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
