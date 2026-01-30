class Tools::PagesController < Tools::BaseController
  include Tools::UiFactories

  helper RapidUI::IconsHelper
  helper RapidUI::Content::BadgesHelper

  def index
    build_breadcrumb "Home"
  end

  def baking_rack
    build_breadcrumb "Baking Rack"
    add_github_button "https://github.com/rapidlybuilt/baking_rack"

    @gem_name = "baking_rack"
    render :readme
  end

  def rapidly_built
    build_breadcrumb "Rapidly Built"
    add_github_button "https://github.com/rapidlybuilt/rapidly_built"

    @gem_name = "rapidly_built"
    render :readme
  end

  private

  def add_github_button(url)
    # TODO: fix rapid_ui to allow pulling in other icons (ie github)
    # ui.layout.subheader.build_button("github", url, title: "GitHub")
  end
end
