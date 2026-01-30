# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/ui_layouts/pages_controller.rb
module UiDocs
  class UiLayouts::PagesController < UiLayouts::BaseController
    before_action :set_main_sidebar

    def index
      build_breadcrumb("Home")
    end

    private

    def set_main_sidebar
      with_navigation_sidebar do |sidebar|
        sidebar.title = "Layouts"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Home", layouts_root_path)
          navigation.build_link("Application", layouts_application_path)
        end
      end
    end
  end
end
