# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/components/controls/datatables_controller.rb
module UiDocs
  class Components::Controls::DatatablesController < Components::BaseController
    include RapidUI::UsesDatatables
    include Components::Controls::DatatablesLayout
    include ReplaysActionsWithCookie

    before_action :set_countries
    before_action :set_full_example_table

    def index
      respond_with_component(@full_example_table)
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
      respond_with_component(set_full_example_table)
    end

    private

    def set_countries
      @countries = YAML.load_file(UiDocs::Engine.root.join("db", "countries.yml")).map do |country|
        Country.new(id: country["name"].underscore, **country)
      end
    end

    def set_full_example_table
      id = :full_example
      @cookie_actions = find_cookie_actions("datatables_#{id}", path: url_for(action: "index"))
      countries = @cookie_actions.replay(@countries)

      @full_example_table = build_datatable(CountriesTable, countries, id:) do |table|
        table.action_name = "index"

        table.header.items.last.build_component(
          RapidUI::Button,
          "Reset",
          path: table.table_path(view_context:, action: "bulk_action", bulk_action: "reset"),
          class: "btn btn-outline-danger",
          disabled: @cookie_actions.cookie_value.blank?,
          data: { turbo_stream: true, turbo_method: :post },
        )
      end
    end
  end
end
