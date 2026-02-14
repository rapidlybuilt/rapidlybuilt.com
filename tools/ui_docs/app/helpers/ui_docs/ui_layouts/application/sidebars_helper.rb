# Copied from RapidUI | Source: rapid_ui/docs/app/helpers/ui_layouts/application/sidebars_helper.rb
module UiDocs
  module UiLayouts::Application::SidebarsHelper
    def layout_application_sidebar_navigation
      demo_components do |c|
        c << layout.build_sidebar do |sidebar|
          sidebar.title = "Workspace"

          sidebar.build_navigation do |navigation|
            navigation.build_link("Dashboard", "#")

            navigation.build_section("Projects", expanded: true) do |section|
              section.path = "#"
              section.build_link("Active", "#")
              section.build_link("Archived", "#")
            end

            navigation.build_section("Reports") do |section|
              section.path = "#"
              section.build_link("Weekly", "#", active: true)
              section.build_link("Monthly", "#")
            end
          end
        end
      end
    end

    def layout_application_sidebar_position
      left = layout.build_sidebar(position: :left) do |sidebar|
        sidebar.title = "Left Sidebar"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Navigation", "#")
          navigation.build_link("Links", "#")
        end
      end

      right = layout.build_sidebar(position: :right) do |sidebar|
        sidebar.title = "Right Sidebar"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Panel", "#")
          navigation.build_link("Options", "#")
        end
      end

      tag.div class: "w-full flex justify-between" do
        safe_join [ render(left), render(right) ]
      end
    end

    def layout_application_sidebar_table_of_contents
      demo_components do |c|
        c << layout.build_sidebar(position: :right) do |sidebar|
          sidebar.title = "On this page"

          sidebar.build_table_of_contents do |toc|
            toc.build_link("Introduction", "#introduction")
            toc.build_link("Getting Started", "#getting-started")
            toc.build_list do |list|
              list.build_link("Installation", "#installation")
              list.build_link("Configuration", "#configuration")
              list.build_list do |list|
                list.build_link("Settings", "#settings")
              end
            end
            toc.build_link("API Reference", "#api-reference")
          end
        end
      end
    end

    def layout_application_sidebar_persisted_state
      demo_components do |c|
        # Don't let the demo get stuck closed
        c << link_to("Force Open", "#", class: "btn btn-primary btn-sm float-right", data: { controller: "toggle-button", action: "click->toggle-button#on", "toggle-button-target-value": "demo_sidebar_persisted_state" })

        c << layout.build_sidebar(id: "demo_sidebar_persisted_state") do |sidebar|
          sidebar.title = "Persisted State"

          sidebar.build_navigation do |navigation|
            navigation.build_link("Home", "#")
          end
        end
      end
    end

    def layout_application_sidebar_complete
      demo_components do |c|
        # Don't let the demo get stuck closed
        c << link_to("Force Open", "#", class: "btn btn-primary btn-sm float-right", data: { controller: "toggle-button", action: "click->toggle-button#on", "toggle-button-target-value": "demo_sidebar_complete" })

        c << layout.build_sidebar(id: "demo_sidebar_complete") do |sidebar|
          sidebar.title = "Application"

          sidebar.build_navigation do |navigation|
            navigation.build_link("Home", "#")

            navigation.build_section("Projects", expanded: true) do |section|
              section.path = "#"
              section.build_link("All Projects", "#", active: true)
              section.build_link("Active", "#")
              section.build_link("Archived", "#")
            end

            navigation.build_section("Team") do |section|
              section.path = "#"
              section.build_link("Members", "#")
              section.build_link("Roles", "#")
              section.build_link("Invitations", "#")
            end

            navigation.build_section("Settings") do |section|
              section.path = "#"
              section.build_link("General", "#")
              section.build_link("Billing", "#")
              section.build_link("Integrations", "#")
            end
          end
        end
      end
    end
  end
end
