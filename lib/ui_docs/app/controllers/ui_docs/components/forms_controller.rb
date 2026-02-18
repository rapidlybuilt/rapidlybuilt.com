# Copied from RapidUI | Source: rapid_ui/docs/app/controllers/components/forms_controller.rb
module UiDocs
  class Components::FormsController < Components::BaseController
    helper RapidUI::FormsHelper
    helper RapidUI::Content::BadgesHelper

    def field_groups
      @user = User.new(
        id: 1,
        first_name: "John",
        last_name: "Doe",
        email: "user@example.com",
        user_type: "regular",
      )

      # Add validation errors for testing
      @user.errors.add(:email, "has already been taken")
    end

    private

    def set_breadcrumbs
      super
      build_breadcrumb("Forms", components_forms_path)
    end
  end
end
