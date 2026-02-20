class Gems::BaseController < ActionController::Base
  include RapidlyBuilt::UsesConsole

  before_action :build_sidebar

  private

  def build_sidebar
    with_navigation_sidebar do |sidebar|
      sidebar.title = "Gems"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", gems_root_path)
        navigation.build_link("Baking Rack", gems_baking_rack_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
        navigation.build_link("Rapid UI", gems_rapid_ui_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
        navigation.build_link("Rapidly Built", gems_rapidly_built_path).with_badge(variant: "warning", class: "text-xs").with_content("beta")
      end
    end
  end
end
