class Tools::SearchesController < Tools::BaseController
  def show
    ui.layout.subheader.css_class = "hidden"
    ui.layout.sidebars.first.css_class = "hidden" if ui.layout.sidebars.first.present?

    page = ui.build(RapidUI::Search::Page)
    page.static_path = tools_search_api_path(format: :json)

    render page
  end
end
