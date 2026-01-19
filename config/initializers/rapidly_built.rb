require "tools/context_middleware"

RapidlyBuilt.config do |config|
  toolkit = config.build_toolkit :tools, tools: [UiDocs::Tool]
  toolkit.context_middleware.use Tools::ContextMiddleware
end
