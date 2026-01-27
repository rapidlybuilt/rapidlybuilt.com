# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/ui_layouts/application/footers_helper.rb
module UiDocs
  module UiLayouts::Application::FootersHelper
    def layout_application_footer_complete
      demo_components do |c|
        c << layout.build_footer do |footer|
          footer.build_left do |left|
            left.build_text_link("Feedback", "#")

            left.build_dropdown(direction: "up") do |dropdown|
              dropdown.build_button("Resources")

              dropdown.build_menu do |menu|
                menu.build_item("Documentation", "#")
                menu.build_item("API Reference", "#")
                menu.build_item("Status Page", "#")
              end
            end
          end

          footer.build_right do |right|
            right.build_text_link("Privacy", "#")
            right.build_text_link("Terms", "#")
            right.build_icon_link("info", "#")
            right.build_icon_link("settings", "#")
            right.build_copyright(start_year: 2024, company_name: "Acme Corp")
          end
        end
      end
    end

    def layout_application_footer_position
      demo_components do |c|
        c << layout.build_footer do |footer|
          footer.build_left do |left|
            left.build_text_link("Left content", "#")
          end

          footer.build_right do |right|
            right.build_text_link("Right content", "#")
          end
        end
      end
    end

    def layout_application_footer_copyright
      demo_components do |c|
        c << ui.build(RapidUI::Layout::Footer::Base) do |footer|
          footer.build_left do |right|
            right.build_copyright(start_year: 2024, company_name: "Acme Corp")
          end
        end
      end
    end

    def layout_application_footer_text_link
      demo_components do |c|
        c << layout.build_footer do |footer|
          footer.build_left do |right|
            right.build_text_link("Privacy", "#")
            right.build_text_link("Terms", "#")
            right.build_text_link("Contact", "#")
          end
        end
      end
    end

    def layout_application_footer_icon_link
      demo_components do |c|
        c << layout.build_footer do |footer|
          footer.build_left do |right|
            right.build_icon_link("info", "#")
            right.build_icon_link("settings", "#")
            right.build_icon_link("user", "#")
          end
        end
      end
    end

    def layout_application_footer_dropdown
      demo_components do |c|
        c << layout.build_footer do |footer|
          footer.build_left do |left|
            left.build_dropdown(direction: "up") do |dropdown|
              dropdown.build_button("Legal")

              dropdown.build_menu do |menu|
                menu.build_item("Privacy Policy", "#")
                menu.build_item("Terms of Service", "#")
                menu.build_item("Cookie Settings", "#")
              end
            end
          end
        end
      end
    end
  end
end
