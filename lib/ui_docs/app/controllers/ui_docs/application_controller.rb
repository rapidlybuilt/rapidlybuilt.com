# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/application_controller.rb
module UiDocs
  class ApplicationController < ActionController::Base
    include RapidlyBuilt::Setup
    include UiFactories

    helper RapidUI::LayoutHelper
    helper RapidUI::IconsHelper

    before_action :add_home_breadcrumb

    private

    def add_home_breadcrumb
      build_breadcrumb("RapidUI", root_path)
    end
  end
end
