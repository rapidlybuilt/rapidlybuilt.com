# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/ui_layouts/application/headers_helper.rb
module UiDocs
  module UiLayouts::Application::HeadersHelper
    def layout_application_header_position
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_text("Left side content")
          end

          header.build_right do |right|
            right.build_text("Right side content")
          end
        end
      end
    end

    # TODO: implement a real search for this demo
    def layout_application_header_search
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_search_bar(static_path: "/tools/search.json")
          end
        end
      end
    end

    def layout_application_header_dropdown
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_dropdown(skip_caret: true) do |dropdown|
              dropdown.build_button(new_icon("layout-grid"))

              dropdown.build_menu do |menu|
                menu.build_item("Dashboard", "#")
                menu.build_item("Settings", "#")
                menu.build_divider
                menu.build_item("Logout", "#")
              end
            end
          end

          header.build_right do |right|
            right.build_dropdown do |dropdown|
              dropdown.build_button("Account")

              dropdown.build_menu do |menu|
                menu.build_item("Profile", "#")
                menu.build_item("Sign Out", "#")
              end
            end
          end
        end
      end
    end

    def layout_application_header_text
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_text("Welcome, Jane")
          end

          header.build_right do |right|
            right.build_text("username")
          end
        end
      end
    end

    def layout_application_header_text_link
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_text_link("Documentation", "#")
            left.build_text_link("API", "#")
            left.build_text_link("Pricing", "#")
          end
        end
      end
    end

    def layout_application_header_icon_link
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_right do |right|
            right.build_icon_link("info", "#")
            right.build_icon_link("settings", "#")
            right.build_icon_link("circle-question-mark", "#")
          end
        end
      end
    end

    def layout_application_header_complete
      demo_components do |c|
        c << layout.build_header do |header|
          header.build_left do |left|
            left.build_icon_link("menu", "#", size: 24)

            left.build_dropdown(skip_caret: true) do |dropdown|
              dropdown.build_button(new_icon("layout-grid"))

              dropdown.build_menu do |menu|
                menu.build_item("Dashboard", "#")
                menu.build_item("Projects", "#")
                menu.build_divider
                menu.build_item("Settings", "#")
              end
            end

            left.build_search_bar(static_path: "/tools/search.json")
          end

          header.build_right do |right|
            right.build_text("Jane Doe", class: "hidden lg:block")

            right.build_icon_link("info", "#")
            right.build_icon_link("settings", "#")

            right.build_dropdown(align: "right") do |dropdown|
              dropdown.build_button("Account")

              dropdown.build_menu do |menu|
                menu.build_item("Profile", "#")
                menu.build_item("Preferences", "#")
                menu.build_divider
                menu.build_item("Sign Out", "#")
              end
            end
          end
        end
      end
    end
  end
end
