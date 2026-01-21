# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/helpers/application_helper.rb
module UiDocs
  module ApplicationHelper
    def render_feature_list(items)
      render "ui_docs/components/categories/list", items:
    end
  end
end
