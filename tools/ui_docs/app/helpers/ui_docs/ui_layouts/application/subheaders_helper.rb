# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/ui_layouts/application/subheaders_helper.rb
module UiDocs
  module UiLayouts::Application::SubheadersHelper
    def layout_application_subheader_sidebar_toggle
      demo_components do |c|
        c << layout.build_subheader do |subheader|
          subheader.build_sidebar_toggle_button(target: ui.layout.sidebars.first)
        end
      end
    end

    def layout_application_subheader_breadcrumbs
      demo_components do |c|
        c << layout.build_subheader do |subheader|
          subheader.build_breadcrumbs do |breadcrumbs|
            breadcrumbs.build_breadcrumb("Home", "#")
            breadcrumbs.build_breadcrumb("Users", "#")
            breadcrumbs.build_breadcrumb("Profile")
          end
        end
      end
    end

    def layout_application_subheader_buttons
      demo_components do |c|
        c << layout.build_subheader do |subheader|
          subheader.build_breadcrumbs do |breadcrumbs|
            breadcrumbs.build_breadcrumb("Dashboard")
          end

          subheader.build_button("settings", "#", title: "Settings")
          subheader.build_button("info", "#", title: "Info")
        end
      end
    end

    def layout_application_subheader_toggle_button
      demo_components do |c|
        c << layout.build_subheader do |subheader|
          subheader.build_breadcrumbs do |breadcrumbs|
            breadcrumbs.build_breadcrumb("Home")
          end

          subheader.build_toggle_button(icon: "chevron-right", title: "Toggle panel", target: ui.layout.sidebars.last)
        end
      end
    end

    def layout_application_subheader_complete
      demo_components do |c|
        c << layout.build_subheader do |subheader|
          subheader.build_sidebar_toggle_button(target: ui.layout.sidebars.first)

          subheader.build_breadcrumbs do |breadcrumbs|
            breadcrumbs.build_breadcrumb("Home", "#")
            breadcrumbs.build_breadcrumb("Settings", "#")
            breadcrumbs.build_breadcrumb("Profile")
          end

          subheader.build_button("settings", "#", title: "Settings")
          subheader.build_button("info", "#", title: "Info")
        end
      end
    end
  end
end
