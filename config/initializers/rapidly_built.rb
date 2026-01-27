RapidlyBuilt.config do |config|
  toolkit = config.build_toolkit :tools, tools: [UiDocs::Tool]
  toolkit.context_middleware.use "ContextMiddleware"
end
