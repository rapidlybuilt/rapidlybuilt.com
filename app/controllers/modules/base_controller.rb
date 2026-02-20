class Modules::BaseController < ApplicationController
  include RapidlyBuilt::UsesConsole
  include Gems::UiFactories

  helper RapidUI::IconsHelper
  helper RapidUI::Content::BadgesHelper

  before_action :build_sidebar

  private

  def build_sidebar
    with_navigation_sidebar do |sidebar|
      sidebar.title = "Modules"

      sidebar.build_navigation do |navigation|
        navigation.build_link("Home", modules_root_path)
      end
    end
  end
end
