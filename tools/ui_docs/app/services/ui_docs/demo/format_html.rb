# Copied from RapidUI | Source: rapid_ui/docs/app/services/demo/format_html.rb
module UiDocs
  # TODO: this is generally useful. Should be outside of test/demo somewhere.
  class Demo::FormatHtml < ApplicationService
    attr_accessor :html

    def initialize(html)
      @html = html
    end

    def call
      return html if html.blank?

      # Parse the HTML with Nokogiri
      doc = Nokogiri::HTML.fragment(html)

      # Format with proper indentation
      formatted = format_node(doc, 0)

      # Clean up extra newlines and return
      formatted.strip
    end

    # HTML5 void elements that should be self-closing
    VOID_ELEMENTS = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def format_node(node, indent_level)
      indent = "  " * indent_level
      result = []
      children = node.children.to_a
      element_children = children.select { |c| c.type == Nokogiri::XML::Node::ELEMENT_NODE }

      children.each_with_index do |child, index|
        case child.type
        when Nokogiri::XML::Node::ELEMENT_NODE
          # Format opening tag
          tag_name = child.name
          attributes = format_attributes(child)
          is_multiline = false

          # Check if there are any element siblings after this one
          has_element_sibling_after = element_children.index(child) < element_children.length - 1

          if child.children.empty?
            # Self-closing or empty tag
            if VOID_ELEMENTS.include?(tag_name)
              result << "#{indent}<#{tag_name}#{attributes}>"
            else
              result << "#{indent}<#{tag_name}#{attributes}></#{tag_name}>"
            end
          elsif tag_name == "svg"
            # Keep SVG tags inline without line breaks
            svg_html = child.to_html.gsub(/\s+/, " ").gsub(/>\s+</, "><").strip
            result << "#{indent}#{svg_html}"
          elsif child.children.size == 1 && child.children.first.text?
            # Single text node child - keep inline
            text_content = child.children.first.text.strip
            result << "#{indent}<#{tag_name}#{attributes}>#{text_content}</#{tag_name}>"
          else
            # Multiple children or non-text children - format with indentation
            is_multiline = true
            result << "#{indent}<#{tag_name}#{attributes}>"
            result << format_node(child, indent_level + 1)
            result << "#{indent}</#{tag_name}>"
          end

          # Add extra line break after multi-line elements (except for the last element child)
          result << "" if is_multiline && has_element_sibling_after
        when Nokogiri::XML::Node::TEXT_NODE
          text = child.text.strip
          result << "#{indent}#{text}" unless text.empty?
        when Nokogiri::XML::Node::COMMENT_NODE
          result << "#{indent}<!-- #{child.text.strip} -->"
        end
      end

      result.join("\n")
    end

    def format_attributes(node)
      return "" if node.attributes.empty?

      attrs = node.attributes.map do |name, attr|
        value = attr.value
        # Escape quotes in attribute values
        value = value.gsub('"', "&quot;") if value.include?('"') && !value.include?("&quot;")
        %Q(#{name}="#{value}")
      end.join(" ")

      " #{attrs}"
    end
  end
end
