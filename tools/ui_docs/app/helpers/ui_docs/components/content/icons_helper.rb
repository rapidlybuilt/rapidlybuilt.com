# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/helpers/components/content/icons_helper.rb
module UiDocs
  module Components::Content::IconsHelper
    def component_content_icons_helper
      demo_components do |c|
        c << new_icon("user")
      end
    end
  end
end
