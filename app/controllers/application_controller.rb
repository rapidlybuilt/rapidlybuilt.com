class ApplicationController < ActionController::Base
  include HasLayout
  include UsesOpenGraph

  before_action :setup_layout

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def setup_layout
    layout.title_suffix = "Rapidly Built"
  end
end
