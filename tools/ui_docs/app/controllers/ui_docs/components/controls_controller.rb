# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/controllers/components/controls_controller.rb
module UiDocs
  class Components::ControlsController < Components::BaseController
    helper RapidUI::ControlsHelper

    private

    def set_breadcrumbs
      super
      build_breadcrumb("Controls", components_controls_path)
    end
  end
end
