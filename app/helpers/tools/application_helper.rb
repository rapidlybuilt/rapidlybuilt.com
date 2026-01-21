module Tools
  module ApplicationHelper
    def render_feature_list(items)
      render "/ui_docs/components/categories/list", items:
    end
  end
end
