# Copied from RapidUI v0.1.0
# Source: rapid_ui/docs/app/services/demo/compare_html.rb
module UiDocs
  class Demo::CompareHtml < ApplicationService
    attr_accessor :helper
    attr_accessor :erb_html
    attr_accessor :helper_html

    attr_accessor :erb_normalized
    attr_accessor :helper_normalized

    def initialize(helper, erb_html, helper_html)
      @helper = helper
      @erb_html = erb_html
      @helper_html = helper_html
    end

    def call
      @erb_normalized = normalize_html_for_comparison(erb_html)
      @helper_normalized = normalize_html_for_comparison(helper_html)

      @success = @erb_normalized == @helper_normalized
    end

    def success?
      @success
    end

    def error_message
        # Find the first difference
        min_length = [ erb_normalized.length, helper_normalized.length ].min
        diff_index = (0...min_length).find { |i| erb_normalized[i] != helper_normalized[i] }

        # If no difference found in the common length, the difference is at the end
        diff_index ||= min_length

        # Show context around the difference
        context_start = [ 0, diff_index - 50 ].max
        context_end = [ erb_normalized.length, diff_index + 50 ].min

        erb_context = erb_normalized[context_start...context_end]
        helper_context = helper_normalized[context_start...context_end]

        # Mark the difference point
        erb_marked = erb_context.dup
        helper_marked = helper_context.dup
        relative_pos = diff_index - context_start

        # Only mark if the position is within the context
        if relative_pos >= 0 && relative_pos < erb_context.length
          erb_marked[relative_pos] = "❌#{erb_marked[relative_pos]}❌"
        end
        if relative_pos >= 0 && relative_pos < helper_context.length
          helper_marked[relative_pos] = "❌#{helper_marked[relative_pos]}❌"
        end

      <<~ERROR
        Helper HTML is not the same: #{helper}

        ERB HTML (normalized):
        #{erb_marked}

        Helper HTML (normalized):
        #{helper_marked}

        Full ERB HTML:\n#{erb_html}

        Full Helper HTML:\n#{helper_html}
      ERROR
    end

    private


    def normalize_html_for_comparison(html)
      # First, normalize all whitespace to single spaces
      normalized = html.gsub(/\s+/, " ")

      # Remove whitespace between HTML tags and content
      # This handles cases like: <button> Notifications</button> vs <button>Notifications</button>
      normalized = normalized.gsub(/>\s+([^<])/, '>\1')

      # Remove whitespace between HTML tags and content (including other HTML tags)
      # This handles cases like: <button> <p>content</p> vs <button><p>content</p>
      normalized = normalized.gsub(/>\s+</, "><")

      # Remove whitespace before closing tags
      # This handles cases like: content </div> vs content</div>
      normalized = normalized.gsub(/\s+<\//, "</")

      # Remove whitespace before opening tags
      # This handles cases like: content <button> vs content<button>
      normalized = normalized.gsub(/([^>])\s+<([^\/])/, '\1<\2')

      # Remove any remaining leading/trailing whitespace
      normalized.strip
    end
  end
end
