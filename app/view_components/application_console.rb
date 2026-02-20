class ApplicationConsole < RapidlyBuilt::Console::Base
  self.search_index_path = :search_index_path
  self.search_path = :search_path

  def build
    request.middleware.use RequestMiddleware
    request.middleware.use RequestSearchPolish

    integrate UiDocs
  end

  class RequestSearchPolish < RapidlyBuilt::Request::Middleware::Entry
    def call
      return unless request.path == helpers.search_path

      ui.layout.header.left.items.last.css_class = "hidden"
      ui.layout.subheader.css_class = "hidden"
      ui.layout.sidebars.first.css_class = "hidden" if ui.layout.sidebars.first.present?
    end
  end
end
