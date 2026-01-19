module Tools
  module UiFactories
    extend ActiveSupport::Concern

    included do
      with_options to: :breadcrumbs do
        delegate :build_breadcrumb
        delegate :with_breadcrumb
      end
    end

    def breadcrumbs
      ui.layout.subheader.breadcrumbs
    end

    def with_navigation_sidebar(&block)
      ui.layout.sidebars.first.tap(&block)
    end
  end
end
