class Tools::PagesController < Tools::BaseController
  include Tools::UiFactories

  helper RapidUI::IconsHelper
  helper RapidUI::Content::BadgesHelper

  def index
    build_breadcrumb "Home", tools_root_path

    with_navigation_sidebar do |sidebar|
      sidebar.title = "Home"

      sidebar.build_navigation do |navigation|
        navigation.build_link("RapidUI", tools_rapid_ui_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
      end
    end
  end
end
