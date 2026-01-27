module UiDocs
  class Tool < RapidlyBuilt::Tool
    def initialize(path: "rapid-ui", **kwargs)
      super(**kwargs, path:)
    end

    def connect(toolkit)
      # Register static search items from YAML file
      static_search_items.each do |item|
        toolkit.search.static.add(
          title: item["title"],
          url: url_for(item["path"]),
          description: item["description"]
        )
      end
    end

    def mount(routes)
      routes.mount UiDocs::Engine => path
    end

    private

    def static_search_items
      yaml_path = UiDocs::Engine.root.join("config/static_search.yml")
      YAML.load_file(yaml_path)
    end

    def url_for(child = "")
      url = File.join("/tools", path, child) # TODO: dynamic "tools"
      url = url[0..-2] if url.end_with?("/")
      url
    end
  end
end
