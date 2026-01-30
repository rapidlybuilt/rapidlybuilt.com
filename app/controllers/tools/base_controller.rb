class Tools::BaseController < ActionController::Base
  include RapidlyBuilt::Setup

  before_action :build_sidebar

  private

  def build_sidebar
    with_navigation_sidebar do |sidebar|
      sidebar.title = "Tools"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", tools_root_path)
        navigation.build_link("Baking Rack", tools_baking_rack_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
        navigation.build_link("Rapid UI", tools_rapid_ui_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
        navigation.build_link("Rapidly Built", tools_rapidly_built_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
      end
    end
  end
end
