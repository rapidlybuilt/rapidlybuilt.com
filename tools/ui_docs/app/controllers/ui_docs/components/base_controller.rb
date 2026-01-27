# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/controllers/components/base_controller.rb
module UiDocs
  class Components::BaseController < ApplicationController
    before_action :set_main_sidebar
    before_action :set_breadcrumbs

    private

    def set_main_sidebar
      sidebar = ui.layout.sidebars.first
      sidebar.title = "Components"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", components_root_path)

        navigation.build_section("Content") do |section|
          section.path = components_content_path

          pending_badge section.build_link("Accordion", "#")
          section.build_link("Badges", components_content_badges_path)
          pending_badge section.build_link("Card", "#")
          pending_badge section.build_link("Carousel", "#")
          section.build_link("Icons", components_content_icons_path)
          pending_badge section.build_link("List group", "#")
          section.build_link("Tables", components_content_tables_path)
          section.build_link("Typography", components_content_typography_path)
        end

        navigation.build_section("Controls") do |section|
          section.path = components_controls_path

          section.build_link("Buttons", components_controls_buttons_path)
          pending_badge section.build_link("Button group", "#")
          pending_badge section.build_link("Datatables", "#")
          section.build_link("Dropdowns", components_controls_dropdowns_path)
          pending_badge section.build_link("Modals", "#")
          pending_badge section.build_link("Tabs", "#")
        end

        navigation.build_section("Feedback") do |section|
          section.path = components_feedback_path

          section.build_link("Alerts", components_feedback_alerts_path)
          pending_badge section.build_link("Popovers", "#")
          pending_badge section.build_link("Progress", "#")
          pending_badge section.build_link("Spinners", "#")
          pending_badge section.build_link("Toasts", "#")
          pending_badge section.build_link("Tooltips", "#")
        end

        navigation.build_section("Forms") do |section|
          section.path = components_forms_path

          section.build_link("Field Groups", components_forms_field_groups_path)
          pending_badge section.build_link("Input group", "#")
          pending_badge section.build_link("Wizard", "#")
        end

        navigation.build_section("Navigation") do |section|
          pending_badge section.build_link("Breadcrumbs", "#")
          pending_badge section.build_link("Pagination", "#")
          pending_badge section.build_link("Table of Contents", "#")
        end

        navigation.build_section("Charts") do |section|
          pending_badge section.build_link("Flot", "#")
          pending_badge section.build_link("Radial", "#")
          pending_badge section.build_link("ChartJS", "#")
        end
      end
    end

    def set_breadcrumbs
      build_breadcrumb("Components", components_root_path)
    end
  end
end
