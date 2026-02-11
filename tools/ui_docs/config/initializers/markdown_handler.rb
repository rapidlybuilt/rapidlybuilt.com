# Copied from RapidUI | Source: rapid_ui/docs/config/initializers/markdown_handler.rb
# frozen_string_literal: true

# Renders .html.md templates with Kramdown (GFM) and Rouge syntax highlighting.
# See app/helpers/markdown_helper.rb for the render implementation.
class MarkdownTemplateHandler
  def self.call(template, source)
    %(tag.div(class: "typography") { render_markdown_with_toc(#{source.inspect}) })
  end
end

Rails.application.config.after_initialize do
  ActionView::Template.register_template_handler :md, MarkdownTemplateHandler
end
