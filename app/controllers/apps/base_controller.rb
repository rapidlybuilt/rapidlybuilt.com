class Apps::BaseController < ApplicationController
  include RapidlyBuilt::Setup
  include Tools::UiFactories

  helper RapidUI::IconsHelper
  helper RapidUI::Content::BadgesHelper

  before_action :build_sidebar

  private

  def build_sidebar
    with_navigation_sidebar do |sidebar|
      sidebar.title = "Apps"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", apps_root_path)
        navigation.build_link("rapidlybuilt.com", apps_rapidlybuilt_com_path)
      end
    end
  end
end
