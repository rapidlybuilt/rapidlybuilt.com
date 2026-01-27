class Tools::SearchesController < Tools::BaseController
  def index
    render json: rapidly_built.toolkit.search.static.as_json
  end
end
