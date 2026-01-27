# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/controllers/stimulus_controller.rb
module UiDocs
  class StimulusController < ApplicationController
    before_action :set_main_sidebar
    before_action :set_breadcrumbs

    def show
      build_breadcrumb("Home")
    end

    private

    def set_main_sidebar
      with_navigation_sidebar do |sidebar|
        sidebar.title = "StimulusJS"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Home", stimulus_path)
          navigation.build_link("Expandable", expandable_stimulus_path)
        end
      end
    end

    def set_breadcrumbs
      build_breadcrumb("StimulusJS", stimulus_path)
    end
  end
end
