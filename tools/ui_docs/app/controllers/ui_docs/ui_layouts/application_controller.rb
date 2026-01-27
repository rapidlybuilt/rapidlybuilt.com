# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/controllers/ui_layouts/application_controller.rb
module UiDocs
  class UiLayouts::ApplicationController < UiLayouts::BaseController
    helper RapidUI::Content::TablesHelper
    helper UiLayouts::Application::HeadersHelper
    helper UiLayouts::Application::SubheadersHelper
    helper UiLayouts::Application::SidebarsHelper
    helper UiLayouts::Application::FootersHelper

    helper_method :layout

    before_action :set_main_sidebar
    before_action :set_breadcrumbs

    def show
      build_breadcrumb("Home")
    end

    def head
      build_breadcrumb("Head")
    end

    def header
      build_breadcrumb("Header")
    end

    def subheader
      build_breadcrumb("Subheader")
    end

    def sidebar
      build_breadcrumb("Sidebar")
    end

    def footer
      build_breadcrumb("Footer")
    end

    private

    def set_main_sidebar
      with_navigation_sidebar do |sidebar|
        sidebar.title = "Application Layout"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Home", layouts_application_path)
          navigation.build_link("Head", head_layouts_application_path)
          navigation.build_link("Header", header_layouts_application_path)
          navigation.build_link("Subheader", subheader_layouts_application_path)
          navigation.build_link("Sidebar", sidebar_layouts_application_path)
          navigation.build_link("Footer", footer_layouts_application_path)
        end
      end
    end

    def set_breadcrumbs
      build_breadcrumb("Application", layouts_application_path)
    end

    def layout
      @layout ||= ui.build(RapidUI::ApplicationLayout)
    end
  end
end
