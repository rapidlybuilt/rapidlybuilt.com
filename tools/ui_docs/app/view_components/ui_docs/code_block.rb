# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/view_components/code_block.rb
module UiDocs
  require "rouge"

  class CodeBlock < ApplicationComponent
    attr_accessor :code
    attr_accessor :language

    with_options to: :code do
      delegate :include?
    end

    def initialize(code, language: nil, **kwargs)
      super(tag_name: :pre, **kwargs, class: merge_classes("code-theme-light", kwargs[:class]))

      @code = code
      @language = language
    end

    def call
      component_tag(highlighted_code)
    end

    def highlighted_code
      return code unless language

      formatter = Rouge::Formatters::HTML.new

      lexer = {
        "ruby" => Rouge::Lexers::Ruby.new,
        "erb" => Rouge::Lexers::ERB.new,
        "html" => Rouge::Lexers::HTML.new,
      }[language] || raise("Unknown language: #{language}")

      formatter.format(lexer.lex(code)).html_safe
    end

    class << self
      def build_from_block_source(block, language:, **kwargs, &callback)
        lines = extract_source!(*block.source_location, language:)
        code = remove_indentation(lines)
        new(code, language:, **kwargs, &callback)
      end

      def build_from_demo_helper(method, language: "ruby", **kwargs, &block)
        lines = extract_source!(*method.source_location, language:)

        raise "first line not demo_components" unless lines[0].include?("demo_components do |c|")
        lines.slice!(0)

        raise "last line not end" unless lines[-1].include?("end")
        lines.pop

        lines.each do |line|
          line.sub!("c << ", "")
        end

        code = remove_indentation(lines)
        new(code, language:, **kwargs, &block)
      end

      def extract_source!(source_file, source_line, language:)
        extract_source(source_file, source_line, language:) ||
        extract_source(source_file, source_line - 1, language:) || # HACK: unsure why Ruby sometimes gives me the next line
          raise("Could not find source")
      end

      def line_indention(line)
        line.match(/^\s*/)[0].length
      end

      def remove_indentation(lines)
        lines = lines.split("\n") unless lines.is_a?(Array)

        first_line = lines[0]
        first_line = lines[1] if first_line == "" && lines[1]

        size = line_indention(first_line)
        lines.map { |line| line.sub(/^\s{0,#{size}}/, "") }.join("\n").strip
      end

      private

      def extract_source(source_file, source_line, language:)
        end_indicator = {
          "erb" => "<% end %>",
          "ruby" => "end",
        }[language] || raise("Unknown language: #{language}")

        source = File.read(source_file).split("\n")
        start_line = source_line
        end_line = nil

        indention = line_indention(source[start_line-1])
        end_source = (" " * indention) + end_indicator

        source[start_line..-1].each_with_index do |line, i|
          if line == end_source
            end_line = start_line + i
            break
          end
        end

        source[start_line..end_line-1] if end_line
      end
    end
  end
end
