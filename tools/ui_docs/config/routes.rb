# Copied from RapidUI | Source: rapid_ui/docs/config/routes.rb
UiDocs::Engine.routes.draw do
  redirect2 = ->(a) do
    redirect { |_params, request| "#{request.script_name}#{a}" }
  end

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

      resources :datatables, only: [ :index ] do
        post :bulk_action, on: :collection

        collection do
          get :features, to: redirect2.call("/components/controls/datatables")
          get "features/columns", as: :columns, action: :columns
          get "features/search", as: :search, action: :search
          get "features/sorting", as: :sorting, action: :sorting
          get "features/pagination", as: :pagination, action: :pagination

          get :extensions, to: redirect2.call("/components/controls/datatables")
          get "extensions/bulk-actions", as: :bulk_actions, action: :bulk_actions
          get "extensions/export", as: :export, action: :export
          get "extensions/select-filters", as: :select_filters, action: :select_filters

          get :adapters, to: redirect2.call("/components/controls/datatables")
          get "adapters/active-record", as: :active_record, action: :active_record
          get "adapters/array", as: :array, action: :array
          get "adapters/kaminari", as: :kaminari, action: :kaminari
        end
      end
    end
    namespace :feedback do
      get :alerts
    end
    namespace :forms do
      get :"field-groups"
    end
  end
end
