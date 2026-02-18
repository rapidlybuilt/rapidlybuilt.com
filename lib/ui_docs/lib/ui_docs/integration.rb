module UiDocs
  class Integration < RapidlyBuilt::Integration::Base
    def call
      # Register static search items from YAML file
      static_search_items.each do |item|
        search.index.add_result(
          title: item["title"],
          url: url_for(item["path"]),
          description: item["description"]
        )
      end
    end

    private

    def static_search_items
      yaml_path = UiDocs::Engine.root.join("config/search_index.yml")
      YAML.load_file(yaml_path)
    end

    def url_for(child = "")
      url = File.join(helpers.root_path, child)
      url = url[0..-2] if url.end_with?("/")
      url
    end
  end
end
