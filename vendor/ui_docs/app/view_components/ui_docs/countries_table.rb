# Copied from RapidUI | Source: rapid_ui/docs/app/view_components/countries_table.rb
module UiDocs
  class CountriesTable < RapidUI::Datatable::Base
    extension :bulk_actions
    extension :export
    extension :select_filters

    adapter :array
    adapter :rails

    columns do |t|
      t.string :name, sortable: true, searchable: true
      t.string :capital
      t.integer :population, sortable: true, sort_order: "desc"
      t.string :region
      t.boolean :un_member, label: "UN Member"
      t.string :openstreetmap, label: "OpenStreetMap"
    end

    self.sort_column = :name
    self.available_per_pages = [ 10, 25, 50, 100 ]
    self.per_page = 10

    # Display options
    self.responsive = true
    self.striped = true
    self.hover = true
    self.bordered = true

    attr_accessor :reset_button_disabled

    self.header_controls = [ :bulk_actions, %i[region_filter search_field_form reset_bulk_action] ]
    self.footer_controls = %i[per_page pagination exports]

    bulk_action :delete

    cell_value :openstreetmap, :html do |record|
      link_to helpers.icon("globe", size: 16), record.openstreetmap, target: "_blank"
    end

    select_filter :region,
      choices: ->(scope) { scope.map(&:region).uniq.sort },
      filter: ->(scope, value) { scope.keep_if { |record| record.region == value } }

    register_control :reset_bulk_action, ->(**kwargs) do
      build(
        RapidUI::Button,
        "Reset",
        path: table.component_path(view_context:, action: "bulk_action", bulk_action: "reset"),
        class: "btn btn-outline-naked",
        disabled: table.reset_button_disabled,
        data: { turbo_stream: true, turbo_method: :post },
      )
    end

    def skip_reset_bulk_action?
      reset_button_disabled.nil?
    end
  end
end
