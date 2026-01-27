# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/components/forms/field_groups_helper.rb
module UiDocs
  module Components::Forms::FieldGroupsHelper
    def component_forms_groups_grid_field_groups
      demo_components do |c|
        c << new_form_field_groups("basic") do |f|
          f.with_email_field_group(:email, colspan: 6)

          f.with_password_field_group(:password, colspan: 6)

          f.with_text_field_group(:address, placeholder: "1234 Main St")

          f.with_text_field_group(:city, value: "Atlanta", colspan: 6)

          f.with_select_group(:state, [ "", "California", "Georgia" ], label: "State/Province", selected: "", colspan: 4)

          f.with_text_field_group(:zip, colspan: 2)

          f.with_radio_button_group :account_type do |g|
            safe_join([
              g.radio_button("personal", checked: true, label: "Personal Account"),
              g.radio_button("business", label: "Business Account"),
              g.radio_button("nonprofit", disabled: true, label: "Non-Profit Organization"),
            ])
          end

          f.with_checkbox_group :subscribe_to_newsletter

          f.with_buttons do |g|
            g.with_submit_button "Register"
            g.with_cancel_link "/"
          end
        end
      end
    end

    def component_forms_groups_horizontal_field_groups
      demo_components do |c|
        c << new_form_field_groups("horizontal_demo", horizontal: true) do |f|
          f.with_text_field_group :email
          f.with_text_field_group :first_name, colspan: 4
          f.with_text_field_group :last_name, colspan: 4
          f.with_radio_button_group :user_type do |g|
            safe_join([
              g.radio_button("regular", checked: true, label: "Regular User"),
              g.radio_button("admin", label: "Admin User"),
              g.radio_button("superadmin", disabled: true, label: "Super Admin User"),
            ])
          end
          f.with_checkbox_group :confirmed
          f.with_buttons do |g|
            g.with_submit_button "Update"
            g.with_cancel_link "Back", "/"
          end
        end
      end
    end

    def component_forms_field_groups_errors
      demo_components do |c|
        c << new_form_field_groups("validation_demo") do |f|
          f.with_email_field_group :email, colspan: 6, error: "Email is required"
          f.with_password_field_group :password, colspan: 6, error: "Password must be at least 8 characters"
        end

        c << new_form_field_groups("horizontal_validation_demo", horizontal: true, class: "mt-8") do |f|
          f.with_group(:email) do |g|
            g.with_error { "Please enter a valid email address. #{link_to 'Learn more', '#', class: "underline"}".html_safe }
            g.email_field
          end
        end
      end
    end

    def component_forms_field_groups_hints
      demo_components do |c|
        c << new_form_field_groups("hint_demo") do |f|
          f.with_text_field_group :username, colspan: 6, hint: "Must be at least 3 characters"
          f.with_email_field_group :email, colspan: 6, hint: "We'll never share your email with anyone else"
          f.with_password_field_group :password, hint: "Use a mix of letters, numbers, and symbols", error: "Password is required"
        end

        c << new_form_field_groups("horizontal_hint_demo", horizontal: true, class: "mt-8") do |f|
          f.with_group(:bio) do |g|
            g.with_hint { "Tell us about yourself in <strong>200 characters</strong> or less".html_safe }
            g.textarea
          end
        end
      end
    end
  end
end
