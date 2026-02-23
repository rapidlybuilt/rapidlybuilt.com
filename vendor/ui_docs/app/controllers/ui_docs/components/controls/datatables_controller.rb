# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/components/controls/datatables_controller.rb
module UiDocs
  class Components::Controls::DatatablesController < Components::BaseController
    include RapidUI::RendersComponents
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
      respond_with_component(set_full_example_table, action: "index")
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

      @full_example_table = ui.build(
        CountriesTable,
        countries,
        id:,
        full_params: params,
        # HACK: should pass this into the control, not the table
        reset_button_disabled: @cookie_actions.cookie_value.blank?,
      )

      add_renderable_component @full_example_table
    end
  end
end
