# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/helpers/components/content/badges_helper.rb
module UiDocs
  module Components::Content::BadgesHelper
    def component_content_badge_variants
      demo_components do |c|
        c << new_primary_badge("Primary")
        c << new_secondary_badge("Secondary")
        c << new_success_badge("Success")
        c << new_danger_badge("Danger")
        c << new_warning_badge("Warning")
      end
    end

    def component_content_badge_pills
      demo_components do |c|
        c << new_primary_pill_badge("Primary")
        c << new_secondary_pill_badge("Secondary")
        c << new_success_pill_badge("Success")
        c << new_danger_pill_badge("Danger")
        c << new_warning_pill_badge("Warning")
      end
    end

    def component_content_badge_sizes
      demo_components do |c|
        c << new_primary_badge("X-Small", class: "text-xs")
        c << new_primary_badge("Small", class: "text-sm")
        c << new_primary_badge("Medium (Default)")
        c << new_primary_badge("Large", class: "text-lg")
        c << new_primary_badge("X-Large", class: "text-xl")
      end
    end

    def component_content_badge_buttons
      demo_components do |c|
        c << new_secondary_button("Messages", new_success_badge(12))
        c << new_outline_primary_button("Drafts", new_primary_badge(7))
      end
    end

    def component_content_badge_html_content
      demo_components do |c|
        c << new_warning_badge.with_content(tag.strong("New"))
      end
    end
  end
end
