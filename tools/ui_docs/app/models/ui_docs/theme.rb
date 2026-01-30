# Copied from RapidUI | Source: rapid_ui/docs/app/models/theme.rb
module UiDocs
  class Theme
    DIRECTORY = UiDocs::Engine.root.join("vendor/stylesheets/themes")

    attr_accessor :id
    attr_accessor :title
    attr_accessor :description
    attr_accessor :typography_variants
    attr_accessor :button_variants

    def path
      id.dasherize
    end

    class TypographyVariant
      attr_accessor :id
      attr_accessor :name
      attr_accessor :description
      attr_accessor :text
      attr_accessor :text_muted
      attr_accessor :bg
      attr_accessor :border
      attr_accessor :link
      attr_accessor :link_hover
      attr_accessor :code_text
      attr_accessor :code_bg

      def initialize(**kwargs)
        kwargs.each do |key, value|
          send("#{key}=", value)
        end

        self.id ||= "#{name}-typography"
      end
    end

    class ButtonVariant
      attr_accessor :id
      attr_accessor :name
      attr_accessor :text
      attr_accessor :bg
      attr_accessor :border
      attr_accessor :text_hover
      attr_accessor :bg_hover
      attr_accessor :border_hover

      def initialize(**kwargs)
        kwargs.each do |key, value|
          send("#{key}=", value)
        end

        self.id ||= "#{name}-button"
      end
    end

    class << self
      def all
        Dir.glob(DIRECTORY.join("*.css")).map do |path|
          id = File.basename(path, ".css")
          next if id == "base"

          find(id)
        end.compact
      end

      def find(id)
        ParseTheme.call(id)
      end
    end
  end
end
