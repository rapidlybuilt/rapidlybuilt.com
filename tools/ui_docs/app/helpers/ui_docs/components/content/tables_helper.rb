# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/helpers/components/content/tables_helper.rb
module UiDocs
  module Components::Content::TablesHelper
    def component_content_table_basic
      demo_components do |c|
        c << new_table do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_variants
      demo_components do |c|
        c << new_table do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "Variant"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row(variant: "light-primary") do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Light Primary"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row(variant: "light-secondary") do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Light Secondary"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row(variant: "dark-primary") do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Dark Primary"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end

            body.build_row(variant: "dark-secondary") do |row|
              row.build_cell "4", scope: "row"
              row.build_cell "Dark Secondary"
              row.build_cell "Sarah"
              row.build_cell "Connor"
              row.build_cell "@sarah"
            end

            body.build_row(variant: "success") do |row|
              row.build_cell "5", scope: "row"
              row.build_cell "Success"
              row.build_cell "John"
              row.build_cell "Doe"
              row.build_cell "@johndoe"
            end

            body.build_row(variant: "danger") do |row|
              row.build_cell "6", scope: "row"
              row.build_cell "Danger"
              row.build_cell "Jane"
              row.build_cell "Smith"
              row.build_cell "@janesmith"
            end

            body.build_row(variant: "warning") do |row|
              row.build_cell "7", scope: "row"
              row.build_cell "Warning"
              row.build_cell "Bob"
              row.build_cell "Johnson"
              row.build_cell "@bob"
            end

            body.build_row(variant: "info") do |row|
              row.build_cell "8", scope: "row"
              row.build_cell "Info"
              row.build_cell "Alice"
              row.build_cell "Williams"
              row.build_cell "@alice"
            end
          end
        end
      end
    end

    def component_content_table_striped
      demo_components do |c|
        c << new_table(striped: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end

            body.build_row do |row|
              row.build_cell "4", scope: "row"
              row.build_cell "John"
              row.build_cell "Doe"
              row.build_cell "@johndoe"
            end
          end
        end
      end
    end

    def component_content_table_hover
      demo_components do |c|
        c << new_table(hover: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_active
      demo_components do |c|
        c << new_table do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row(active: true) do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_bordered
      demo_components do |c|
        c << new_table(bordered: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_borderless
      demo_components do |c|
        c << new_table(borderless: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_small
      demo_components do |c|
        c << new_table(small: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Larry"
              row.build_cell "Bird"
              row.build_cell "@twitter"
            end
          end
        end
      end
    end

    def component_content_table_align_top
      demo_components do |c|
        c << new_table(align: :top) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "Heading 1"
              row.build_cell "Heading 2"
              row.build_cell "Heading 3"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "This cell has a lot of content that spans multiple lines to demonstrate vertical alignment behavior in table cells."
              row.build_cell "Short"
              row.build_cell "Content"
            end
          end
        end
      end
    end

    def component_content_table_align_middle
      demo_components do |c|
        c << new_table(align: :middle) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "Heading 1"
              row.build_cell "Heading 2"
              row.build_cell "Heading 3"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "This cell has a lot of content that spans multiple lines to demonstrate vertical alignment behavior in table cells."
              row.build_cell "Short"
              row.build_cell "Content"
            end
          end
        end
      end
    end

    def component_content_table_align_bottom
      demo_components do |c|
        c << new_table(align: :bottom) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "Heading 1"
              row.build_cell "Heading 2"
              row.build_cell "Heading 3"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "This cell has a lot of content that spans multiple lines to demonstrate vertical alignment behavior in table cells."
              row.build_cell "Short"
              row.build_cell "Content"
            end
          end
        end
      end
    end

    def component_content_table_caption_top
      demo_components do |c|
        c << new_table do |table|
          table.build_caption("List of users")

          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end
          end
        end
      end
    end

    def component_content_table_caption_bottom
      demo_components do |c|
        c << new_table do |table|
          table.build_caption("List of users shown below", position: :bottom)

          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "First"
              row.build_cell "Last"
              row.build_cell "Handle"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Mark"
              row.build_cell "Otto"
              row.build_cell "@mdo"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Jacob"
              row.build_cell "Thornton"
              row.build_cell "@fat"
            end
          end
        end
      end
    end

    def component_content_table_responsive
      demo_components do |c|
        c << new_table(responsive: true) do |table|
          table.build_head do |head|
            head.build_row do |row|
              row.build_cell "#"
              row.build_cell "Heading 1"
              row.build_cell "Heading 2"
              row.build_cell "Heading 3"
              row.build_cell "Heading 4"
              row.build_cell "Heading 5"
              row.build_cell "Heading 6"
              row.build_cell "Heading 7"
              row.build_cell "Heading 8"
              row.build_cell "Heading 9"
            end
          end

          table.build_body do |body|
            body.build_row do |row|
              row.build_cell "1", scope: "row"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
            end

            body.build_row do |row|
              row.build_cell "2", scope: "row"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
            end

            body.build_row do |row|
              row.build_cell "3", scope: "row"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
              row.build_cell "Cell"
            end
          end
        end
      end
    end

    def component_content_property_table_basic
      demo_components do |c|
        c << new_property_table(striped: true, hover: true) do |t|
          t.build_property "Name", "John Doe"
          t.build_property "Email", "john.doe@example.com"
          t.build_property "Phone", "+1 (555) 123-4567"
          t.build_property "Status", "Active"
        end
      end
    end

    def component_content_property_table_html
      demo_components do |c|
        c << new_property_table do |t|
          t.build_property "Name", "John Doe"
          t.build_property("Email", link_to("john.doe@example.com", "mailto:john.doe@example.com"))
          t.build_property("Status", new_badge("Active", variant: "success"))
          t.build_property(
            "Actions",
            new_button("Edit", variant: "primary", size: "sm"),
            new_button("Delete", variant: "danger", size: "sm"),
          )
        end
      end
    end
  end
end
