class SearchesController < ApplicationController
  include RapidlyBuilt::Setup

  def show
    ui.layout.header.left.items.last.css_class = "hidden"
    ui.layout.subheader.css_class = "hidden"
    ui.layout.sidebars.first.css_class = "hidden" if ui.layout.sidebars.first.present?

    page = ui.build(RapidUI::Search::Page)
    page.static_path = search_api_path(format: :json)

    render page
  end
end
