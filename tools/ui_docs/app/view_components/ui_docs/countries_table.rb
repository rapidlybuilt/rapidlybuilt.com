# Copied from RapidUI | Source: rapid_ui/docs/app/view_components/countries_table.rb
module UiDocs
  class CountriesTable < RapidUI::Datatable::Base
    include RapidUI::Datatable::Adapters::Array

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

    bulk_action :delete

    column_html :openstreetmap do |record|
      link_to helpers.icon("globe", size: 16), record.openstreetmap, target: "_blank"
    end

    select_filter :region,
      options: ->(scope) { scope.map(&:region).uniq.sort },
      filter: ->(scope, value) { scope.keep_if { |record| record.region == value } }
  end
end
