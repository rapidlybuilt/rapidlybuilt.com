# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/concerns/components/controls/datatables_layout.rb
module UiDocs
  module Components::Controls::DatatablesLayout
    extend ActiveSupport::Concern

    included do
      skip_before_action :set_main_sidebar, except: [ :index ]
      before_action :build_datatables_sidebar
      before_action :set_child_breadcrumbs, except: [ :index ]
    end

    private

    def set_child_breadcrumbs
      build_breadcrumb("Datatables", components_controls_datatables_path)

      pieces = request.path.split("/")
      build_breadcrumb(pieces[-2].to_s.titleize, pieces[0..-2].join("/"))
      build_breadcrumb(action_name.to_s.titleize)
    end

    def build_datatables_sidebar
      sidebar = ui.layout.sidebars.first
      sidebar.title = "Datatables"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", components_controls_datatables_path)

        navigation.build_section("Features") do |section|
          section.build_link("Columns", columns_components_controls_datatables_path)
          section.build_link("Search", search_components_controls_datatables_path)
          section.build_link("Sorting", sorting_components_controls_datatables_path)
          section.build_link("Export", export_components_controls_datatables_path)
        end

        navigation.build_section("Extensions") do |section|
          section.build_link("Pagination", pagination_components_controls_datatables_path)
          section.build_link("Bulk Actions", bulk_actions_components_controls_datatables_path)
          section.build_link("Select Filter", select_filter_components_controls_datatables_path)
        end

        navigation.build_section("Adapters") do |section|
          section.build_link("ActiveRecord", active_record_components_controls_datatables_path)
          section.build_link("Array", array_components_controls_datatables_path)
          section.build_link("Kaminari", kaminari_components_controls_datatables_path)
        end
      end
    end
  end
end
