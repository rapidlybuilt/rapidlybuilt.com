# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/components/controls/dropdowns_helper.rb
module UiDocs
  module Components::Controls::DropdownsHelper
    def component_controls_dropdowns_variants
      demo_components do |c|
        c << new_primary_dropdown("Primary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_secondary_dropdown("Secondary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_naked_dropdown("Naked") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_success_dropdown("Success") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_warning_dropdown("Warning") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_danger_dropdown("Danger") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end
      end
    end

    def component_controls_dropdowns_outline_variants
      demo_components do |c|
        c << new_outline_primary_dropdown("Outline Primary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_outline_success_dropdown("Outline Success") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_outline_warning_dropdown("Outline Warning") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end

        c << new_outline_danger_dropdown("Outline Danger") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
          end
        end
      end
    end

    def component_controls_dropdowns_sizes
      demo_components do |c|
        c << new_primary_dropdown("Small", size: "sm") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_primary_dropdown("Medium (Default)") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_primary_dropdown("Large", size: "lg") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end
      end
    end

    def component_controls_dropdowns_disabled
      demo_components do |c|
        c << new_primary_dropdown("Primary Disabled", disabled: true) do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_secondary_dropdown("Secondary Disabled", disabled: true) do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_naked_dropdown("Naked Disabled", disabled: true) do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end
      end
    end

    def component_controls_dropdowns_positioning
      demo_components do |c|
        c << new_primary_dropdown("Left Aligned") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_primary_dropdown("Right Aligned", align: "right") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_primary_dropdown("Center Aligned", align: "center") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Action 1", "#")
            menu.build_item("Action 2", "#")
            menu.build_item("Action 3", "#")
          end
        end

        c << new_primary_dropdown("Drop Up", direction: "up") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Up", "#")
            menu.build_item("Position", "#")
          end
        end

        c << new_primary_dropdown("Drop Up-Right", align: "right", direction: "up") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Up", "#")
            menu.build_item("Position", "#")
          end
        end

        c << new_primary_dropdown("Drop Up-Center", align: "center", direction: "up") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Up", "#")
            menu.build_item("Position", "#")
          end
        end
      end
    end

    def component_controls_dropdowns_active_and_disabled
      demo_components do |c|
        c << new_primary_dropdown("Active & Disabled") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Active Item", "#", active: true)
            menu.build_item("Normal Item", "#")
            menu.build_item("Disabled Item", "#", disabled: true)
          end
        end

        c << new_secondary_dropdown("With Icons") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Active Profile", "#", icon: "user", active: true)
            menu.build_item("Settings", "#", icon: "settings")
            menu.build_item("Disabled Billing", "#", icon: "hash", disabled: true)
          end
        end

        c << new_success_dropdown("Success Variant") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Active Success", "#", active: true)
            menu.build_item("Normal Success", "#")
            menu.build_item("Disabled Success", "#", disabled: true)
          end
        end

        c << new_danger_dropdown("Danger Variant") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Active Danger", "#", active: true)
            menu.build_item("Normal Danger", "#")
            menu.build_item("Disabled Danger", "#", disabled: true)
          end
        end
      end
    end

    def component_controls_dropdowns_with_icons
      demo_components do |c|
        c << new_primary_dropdown(icon("user"), "Profile") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Profile", "#", icon: "user")
            menu.build_item("Settings", "#", icon: "settings")
            menu.build_item("Sign Out", "#", icon: "x")
          end
        end

        c << new_secondary_dropdown(icon("settings"), "Options") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Search", "#", icon: "search")
            menu.build_item("Help", "#", icon: "info")
            menu.build_item("Delete", "#", icon: "trash")
          end
        end

        c << new_success_dropdown("Skip Caret", skip_caret: true) do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Search", "#", icon: "search")
            menu.build_item("Help", "#", icon: "info")
            menu.build_item("Delete", "#", icon: "trash")
          end
        end

        c << new_danger_dropdown("") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_item("Search", "#", icon: "search")
            menu.build_item("Help", "#", icon: "info")
            menu.build_item("Delete", "#", icon: "trash")
          end
        end
      end
    end

    def component_controls_dropdowns_with_html_content
      demo_components do |c|
        c << new_primary_dropdown("Profile") do |dropdown|
          dropdown.build_menu do |menu|
            menu.with_content tag.p("This is some HTML content in the menu.", class: "m-2 text-white")
          end
        end

        c << new_secondary_dropdown("Options") do |dropdown|
          dropdown.build_menu do |menu|
            menu.with_content(
              tag.ul(class: "m-4") do
                tag.li("Item 1.") << tag.li("Item 2.") << tag.li("Item 3.")
              end
            )
          end
        end
      end
    end

    def component_controls_dropdowns_menu_headers_and_dividers
      demo_components do |c|
        c << new_primary_dropdown("Primary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_secondary_dropdown("Secondary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_naked_dropdown("Naked") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_success_dropdown("Success") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_warning_dropdown("Warning") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_danger_dropdown("Danger") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_outline_primary_dropdown("Outline Primary") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_outline_success_dropdown("Outline Success") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_outline_warning_dropdown("Outline Warning") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end

        c << new_outline_danger_dropdown("Outline Danger") do |dropdown|
          dropdown.build_menu do |menu|
            menu.build_header("Account")
            menu.build_item("Profile", "#")
            menu.build_divider
            menu.build_item("Sign Out", "#")
          end
        end
      end
    end
  end
end
