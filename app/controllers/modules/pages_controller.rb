class Modules::PagesController < Modules::BaseController
  include Gems::UiFactories

  helper RapidUI::IconsHelper
  helper RapidUI::Content::BadgesHelper

  def index
    build_breadcrumb "Home"
  end
end
