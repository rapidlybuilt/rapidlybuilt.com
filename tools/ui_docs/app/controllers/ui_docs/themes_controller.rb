# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/controllers/themes_controller.rb
module UiDocs
  class ThemesController < ApplicationController
    before_action :set_available_themes
    before_action :set_main_sidebar
    before_action :set_breadcrumbs

    def show
      @theme = Theme.find(params[:id])
    end

    private

    def set_available_themes
      @available_themes = Theme.all
    end

    def set_main_sidebar
      with_navigation_sidebar do |sidebar|
        sidebar.title = "Themes"

        sidebar.build_navigation do |navigation|
          @available_themes.each do |theme|
            navigation.build_link(theme.title, theme_path(theme.id))
          end
        end
      end
    end

    def set_breadcrumbs
      build_breadcrumb("Themes", themes_path)
    end
  end
end
