# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/helpers/components/feedback/alerts_helper.rb
module UiDocs
  module Components::Feedback::AlertsHelper
    def component_feedback_alert_variants
      demo_components do |c|
        c << new_info_alert("This is an informational alert.")
        c << new_success_alert("Your action was successful!")
        c << new_warning_alert("Please be careful with this action.")
        c << new_danger_alert("Something went wrong.")
      end
    end

    def component_feedback_alert_with_icons
      demo_components do |c|
        c << new_info_alert("This alert includes an icon for better visual communication.", icon: "info")
        c << new_success_alert("Your changes have been saved successfully!", icon: "circle-check")
        c << new_warning_alert("This action cannot be undone.", icon: "triangle-alert")
        c << new_danger_alert("Failed to process your request.", icon: "circle-question-mark")
      end
    end

    def component_feedback_alert_dismissible
      demo_components do |c|
        c << new_info_alert("This alert can be dismissed.", dismissible: true)
        c << new_success_alert("This alert can be dismissed.", dismissible: true) do |a|
          a.build_close_button "Dismiss"
        end
      end
    end
  end
end
