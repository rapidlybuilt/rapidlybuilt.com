class ApplicationToolkit < RapidlyBuilt::Toolkit::Base
  def initialize
    super
    request.middleware.use RequestMiddleware

    add_tool UiDocs::Tool
  end
end
