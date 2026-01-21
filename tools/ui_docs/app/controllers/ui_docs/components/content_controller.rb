# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/controllers/components/content_controller.rb
module UiDocs
  class Components::ContentController < Components::BaseController
    helper RapidUI::ContentHelper
    helper RapidUI::Controls::ButtonsHelper

    private

    def set_breadcrumbs
      super
      build_breadcrumb("Content", components_content_path)
    end
  end
end
