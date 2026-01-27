class Tools::SearchesController < Tools::BaseController
  def show
    # this search is only static because it's meant for a pre-rendered static site

    respond_to do |format|
      format.json do
        render json: rapidly_built.toolkit.search.static.as_json
      end

      format.html do
        ui.layout.subheader.css_class = "hidden"
        ui.layout.sidebars.first.css_class = "hidden" if ui.layout.sidebars.first.present?

        page = ui.build(RapidUI::Search::Page)
        page.static_path = tools_search_path(format: :json)

        render page
      end
    end
  end
end
