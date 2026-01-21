# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/controllers/concerns/ui_factories.rb
module UiDocs
  module UiFactories
    def self.included(base)
      base.class_eval do
        helper_method :build_breadcrumb, :with_breadcrumb
      end
    end

    def pending_badge(link, variant: "warning")
      link.with_badge(variant:, class: "text-xs").with_content("TODO")
    end

    with_options to: :view_context do
      delegate :new_icon
    end

    def with_navigation_sidebar(&block)
      ui.layout.sidebars.first.tap(&block)
    end

    def breadcrumbs
      ui.layout.subheader.breadcrumbs
    end

    with_options to: :breadcrumbs do
      delegate :build_breadcrumb
      delegate :with_breadcrumb
    end
  end
end
