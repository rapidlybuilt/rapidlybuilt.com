# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/config/routes.rb
UiDocs::Engine.routes.draw do
  root to: "pages#index"

  get "search", to: "search#show"

  resource :stimulus, only: [ :show ] do
    get :expandable
  end

  resources :themes, only: %i[ index show ]

  namespace :components do
    root to: "categories#index"
    get :content, to: "categories#content"
    get :controls, to: "categories#controls"
    get :feedback, to: "categories#feedback"
    get :forms, to: "categories#forms"

    namespace :content do
      get :badges
      get :tables
      get :typography
      get :icons
    end
    namespace :controls do
      get :buttons
      get :dropdowns
    end
    namespace :feedback do
      get :alerts
    end
    namespace :forms do
      get :"field-groups"
    end
  end
end
