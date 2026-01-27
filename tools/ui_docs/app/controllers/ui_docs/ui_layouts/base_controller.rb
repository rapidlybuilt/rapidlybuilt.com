# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/controllers/ui_layouts/base_controller.rb
module UiDocs
  class UiLayouts::BaseController < ApplicationController
    before_action :set_layouts_breadcrumbs

    private

    def set_layouts_breadcrumbs
      build_breadcrumb("Layouts", layouts_root_path)
    end
  end
end
