# Copied from RapidUI | Source: rapid_ui/docs/config/routes.rb
UiDocs::Engine.routes.draw do
  root to: "pages#index"

  # get "search", to: "search#show"

  resource :stimulus, only: [ :show ] do
    get :expandable
  end

  resources :themes, only: %i[ index show ]

  namespace :layouts, module: "ui_layouts" do
    root to: "pages#index"

    resource :application, controller: "application", only: [ :show ] do
      get :head
      get :header
      get :subheader
      get :sidebar
      get :footer
    end
  end

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
