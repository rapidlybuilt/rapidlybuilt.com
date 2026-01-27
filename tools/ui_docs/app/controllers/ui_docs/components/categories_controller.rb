# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/controllers/components/categories_controller.rb
module UiDocs
  class Components::CategoriesController < Components::BaseController
    helper RapidUI::Content::BadgesHelper

    def index
      build_breadcrumb("Home")
    end

    def content
      build_breadcrumb("Content")
    end

    def controls
      build_breadcrumb("Controls")
    end

    def feedback
      build_breadcrumb("Feedback")
    end

    def forms
      build_breadcrumb("Forms")
    end

    def navigation
      build_breadcrumb("Navigation")
    end

    def charts
      build_breadcrumb("Charts")
    end

    private

    def set_breadcrumbs
      build_breadcrumb("Components", components_root_path)
    end
  end
end
