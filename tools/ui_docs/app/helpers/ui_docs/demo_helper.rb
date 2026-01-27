# Copied from RapidUI v0.1.4
# Source: rapid_ui/docs/app/helpers/demo_helper.rb
module UiDocs
  module DemoHelper
    def demo_code(helper: nil, flex: false, skip_html_check: false, content_class: nil, &erb_block)
      erb_html = capture(&erb_block) if erb_block
      helper_html = send(helper) if helper
      html = CodeBlock.remove_indentation(helper_html || erb_html)

      # ensure the helper and ERB are the same (minus whitespace)
      if erb_html && helper_html && !skip_html_check
        demo_check_html(helper, erb_html, helper_html)
      end

      erb_code = CodeBlock.build_from_block_source(erb_block, language: "erb", factory: ui.factory) if erb_block
      ruby_code = CodeBlock.build_from_demo_helper(method(helper), factory: ui.factory) if helper
      html_code = CodeBlock.new(demo_format_html(html), language: "html", factory: ui.factory)

      erb_code = nil if erb_code && !erb_code.include?("<%")

      render ui.build(
        Demo,
        html: erb_html || helper_html,
        erb_code:,
        ruby_code:,
        html_code:,
        content_class: (content_class || (flex ? "demo-flex" : nil)), # TODO: rename flex option "inline"
      )
    end

    def new_demo_code_block(code = nil, language: nil, **kwargs, &block)
      raise ArgumentError, "either code or block must be provided" if code.blank? && block.blank?

      if block
        code = capture(&block)
        code = CodeBlock.remove_indentation(code)
      end

      CodeBlock.new(code, language:, **kwargs, factory: ui.factory)
    end

    def demo_code_block(code = nil, language: nil, **kwargs, &block)
      render new_demo_code_block(code, language:, **kwargs, &block)
    end

    def demo_components(&block)
      demo_components = []
      block.call(demo_components)
      safe_join(demo_components.map { |c| c.is_a?(String) ? c : render(c) })
    end

    def demo_check_html(helper, erb_html, helper_html)
      service = Demo::CompareHtml.new(helper, erb_html, helper_html)
      service.call
      raise service.error_message unless service.success?
    end

    def demo_format_html(html)
      Demo::FormatHtml.call(html)
    end
  end
end
