# Copied from RapidUI | Source: rapid_ui/docs/app/helpers/components/controls/buttons_helper.rb
module UiDocs
  module Components::Controls::ButtonsHelper
    def component_controls_buttons_variants
      demo_components do |c|
        c << new_primary_button("Primary")
        c << new_secondary_button("Secondary")
        c << new_naked_button("Naked")
        c << new_success_button("Success")
        c << new_warning_button("Warning")
        c << new_danger_button("Danger")
      end
    end

    def component_controls_buttons_outline_variants
      demo_components do |c|
        c << new_outline_primary_button("Outline Primary")
        c << new_outline_success_button("Outline Success")
        c << new_outline_warning_button("Outline Warning")
        c << new_outline_danger_button("Outline Danger")
      end
    end

    def component_controls_buttons_links
      demo_components do |c|
        c << new_primary_button("Primary Link", path: "#")
        c << new_secondary_button("Secondary Link", path: "#")
        c << new_naked_button("Naked Link", path: "#")
        c << new_success_button("Success Link", path: "#")
        c << new_warning_button("Warning Link", path: "#")
        c << new_danger_button("Danger Link", path: "#")
        c << new_outline_primary_button("Outline Primary Link", path: "#")
        c << new_outline_success_button("Outline Success Link", path: "#")
        c << new_outline_warning_button("Outline Warning Link", path: "#")
        c << new_outline_danger_button("Outline Danger Link", path: "#")
      end
    end

    def component_controls_buttons_sizes
      demo_components do |c|
        c << new_primary_button("Small", size: "sm")
        c << new_primary_button("Medium (Default)")
        c << new_primary_button("Large", size: "lg")
      end
    end

    def component_controls_buttons_circular
      demo_components do |c|
        c << new_primary_button(icon("menu", size: 20), class: "btn-circular")
        c << new_secondary_button(icon("x", size: 20), class: "btn-circular")
        c << new_naked_button(icon("settings", size: 20), class: "btn-circular")
        c << new_success_button(icon("check", size: 20), class: "btn-circular")
        c << new_warning_button(icon("triangle-alert", size: 20), class: "btn-circular")
        c << new_danger_button(icon("trash", size: 20), class: "btn-circular")
      end
    end

    def component_controls_buttons_with_icons
      demo_components do |c|
        c << new_primary_button(icon("search") + "Search")
        c << new_secondary_button(icon("settings") + "Settings")
        c << new_naked_button(icon("info") + "Info")
        c << new_success_button(icon("check") + "Save")
        c << new_warning_button(icon("triangle-alert") + "Warning")
        c << new_danger_button(icon("trash") + "Delete")
      end
    end

    def component_controls_buttons_disabled
      demo_components do |c|
        c << new_primary_button("Primary Disabled", disabled: true)
        c << new_secondary_button("Secondary Disabled", disabled: true)
        c << new_naked_button("Naked Disabled", disabled: true)
        c << new_success_button("Success Disabled", disabled: true)
        c << new_warning_button("Warning Disabled", disabled: true)
        c << new_danger_button("Danger Disabled", disabled: true)
        c << new_outline_primary_button("Outline Primary Disabled", disabled: true)
        c << new_outline_success_button("Outline Success Disabled", disabled: true)
        c << new_outline_warning_button("Outline Warning Disabled", disabled: true)
        c << new_outline_danger_button("Outline Danger Disabled", disabled: true)
      end
    end

    def component_controls_buttons_circular_buttons
      demo_components do |c|
        c << new_primary_button(icon("menu", size: 20), class: "btn-circular")
        c << new_secondary_button(icon("x", size: 20), class: "btn-circular")
        c << new_naked_button(icon("settings", size: 20), class: "btn-circular")
        c << new_success_button(icon("check", size: 20), class: "btn-circular")
        c << new_warning_button(icon("triangle-alert", size: 20), class: "btn-circular")
        c << new_danger_button(icon("trash", size: 20), class: "btn-circular")
        c << new_outline_primary_button(icon("search", size: 20), class: "btn-circular")
        c << new_outline_success_button(icon("circle-check", size: 20), class: "btn-circular")
        c << new_outline_danger_button(icon("loader", size: 20, spin: true), class: "btn-circular")
        c << new_outline_warning_button(icon("info", size: 40), class: "btn-circular")
      end
    end

    def component_controls_buttons_with_icons
      demo_components do |c|
        c << new_primary_button(icon("search") + "Search")
        c << new_secondary_button(icon("settings") + "Settings")
        c << new_naked_button(icon("info") + "Info")
        c << new_success_button(icon("check") + "Save")
        c << new_warning_button(icon("triangle-alert") + "Warning")
        c << new_danger_button(icon("trash") + "Delete")
        c << new_outline_primary_button(icon("user") + "Profile")
        c << new_outline_success_button(icon("circle-check") + "Confirm")
        c << new_outline_warning_button(icon("info") + "Alert")
        c << new_outline_danger_button(icon("loader", spin: true) + "Loading")
      end
    end

    def component_controls_buttons_html_content
      demo_components do |c|
        c << new_outline_warning_button(
          %(<p>This is some <strong>HTML</strong> content #{icon("info", class: "inline")} in the <code>button</code> body.</p>).html_safe
        )
      end
    end
  end
end
