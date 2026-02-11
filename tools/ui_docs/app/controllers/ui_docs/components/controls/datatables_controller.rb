# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/components/controls/datatables_controller.rb
module UiDocs
  class Components::Controls::DatatablesController < Components::BaseController
    include UsesRapidTables
    include ReplaysActionsWithCookie

    skip_before_action :set_main_sidebar, except: [ :index ]
    before_action :build_datatables_sidebar

    before_action :set_countries
    before_action :set_full_example_table
    before_action :set_child_breadcrumbs, except: [ :index ]

    def index
      respond_with_rapid_table(@full_example_table)
    end

    def bulk_action
      case params[:bulk_action]
      when "reset"
        @cookie_actions.reset
      when "delete"
        @cookie_actions.bulk_delete(ids: params[:ids])
      else
        raise BadRequestError, "Invalid bulk action: #{params[:bulk_action]}"
      end

      # reload the table with the latest changes
      respond_with_rapid_table(set_full_example_table)
    end

    private

    def set_countries
      @countries = YAML.load_file(UiDocs::Engine.root.join("db", "countries.yml")).map do |country|
        Country.new(id: country["name"].underscore, **country)
      end
    end

    def set_full_example_table
      id = :full_example
      @cookie_actions = find_cookie_actions("datatables_#{id}")
      countries = @cookie_actions.replay(@countries)

      @full_example_table = rapid_table(countries, title: "Countries", table_class: CountriesTable, id:) do |table|
        table.table_name = "countries"
        table.action_name = "index"

        table.header.items.last.build_button(
          "Reset",
          path: table.table_path(view_context:, action: "bulk_action", bulk_action: "reset"),
          class: "btn btn-danger",
          disabled: @cookie_actions.cookie_value.blank?,
          data: { turbo_stream: true, turbo_method: :post },
        )
      end
    end

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
