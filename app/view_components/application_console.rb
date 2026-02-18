class ApplicationConsole < RapidlyBuilt::Console::Base
  def initialize(**kwargs)
    super(**kwargs)

    request.middleware.use RequestMiddleware

    integrate UiDocs
  end
end
