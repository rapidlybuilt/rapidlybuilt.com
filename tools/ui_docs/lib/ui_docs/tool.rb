module UiDocs
  class Tool < RapidlyBuilt::Tool
    def initialize(path: "rapid-ui", **kwargs)
      super(**kwargs, path:)
    end

    def mount(routes)
      routes.mount UiDocs::Engine => path
    end
  end
end
