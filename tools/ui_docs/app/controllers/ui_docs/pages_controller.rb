# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/controllers/pages_controller.rb
module UiDocs
  class PagesController < ApplicationController
    def index
      with_navigation_sidebar do |sidebar|
        sidebar.title = "Home"

        sidebar.build_navigation do |navigation|
          navigation.build_link("Home", root_path)
          navigation.build_link("Components", components_root_path)
          navigation.build_link("StimulusJS", stimulus_path)
          navigation.build_link("Themes", themes_path)
        end
      end
    end
  end
end
