# Copied from RapidUI | Source: rapid_ui/docs/app/helpers/markdown_helper.rb
module UiDocs
  # frozen_string_literal: true

  require "kramdown"
  require "kramdown-parser-gfm"
  require "rouge"

  module MarkdownHelper
    # Renders markdown to HTML using Kramdown with GFM and Rouge syntax highlighting.
    # Use in .html.md templates via the registered :md template handler.
    def self.render(source)
      html = kramdown_html(source)

      apply_code_theme(html).html_safe
    end

    # Renders markdown with table-of-contents sidebar (same behavior as rapidlybuilt_com).
    # Sets up rapid_ui sidebar, scrollspy, and toggle; builds TOC from h2+; outputs inline TOC + content.
    def render_markdown_with_toc(source, typography: true)
      doc = Kramdown::Document.new(
        source,
        input: "GFM",
        syntax_highlighter: :rouge,
        syntax_highlighter_opts: {
          default_lang: "ruby",
          formatter: Rouge::Formatters::HTML.new,
        },
      )

      headers = doc.root.children.select { |el| el.type == :header }.map do |el|
        [ el.options[:level], el.options[:raw_text].to_s ]
      end

      sidebar = ui.layout.with_sidebar(id: "table_of_contents", position: :right, title: "On this page")

      ui.layout.main_container.data.merge!(
        controller: "scrollspy",
        scrollspy_active_class: "active",
      )

      ui.layout.main.data.merge!(
        scrollspy_target: "content",
      )

      ui.layout.subheader.with_toggle_button(
        title: "Toggle table of contents",
        icon: "info",
        target: sidebar,
        class: "hidden lg:block",
      )

      toc = sidebar.with_table_of_contents
      build_toc_from_headers(toc, headers)

      converter_options = doc.options.merge(
        view_context: self,
        typography: typography,
        syntax_highlighter: :rouge,
        syntax_highlighter_opts: {
          default_lang: "ruby",
          formatter: Rouge::Formatters::HTML.new,
        },
      )
      content_html = TocConverter.convert(doc.root, converter_options).first
      content_html = MarkdownHelper.apply_code_theme(content_html).html_safe

      safe_join([
        tag.div(
          safe_join([
            tag.h2(sidebar.title, class: "toc-inline-title"),
            render(toc),
          ]),
          class: "toc-inline-container block lg:hidden",
        ),
        content_html,
      ])
    end

    class << self
      def kramdown_html(source)
        Kramdown::Document.new(
          source,
          input: "GFM",
          syntax_highlighter: :rouge,
          syntax_highlighter_opts: {
            default_lang: "ruby",
            formatter: Rouge::Formatters::HTML.new,
          },
        ).to_html
      end

      def apply_code_theme(html)
        html
          .gsub(%r{<pre class="([^"]*)"}, '<pre class="code-theme-light \1"')
          .gsub(%r{<pre><}, '<pre class="code-theme-light"><')
      end
    end

    private

    def build_toc_from_headers(toc, headers)
      list_stack = [ toc ]
      last_level = 1

      headers.each do |level, title|
        next if level < 2

        id = title.parameterize
        path = "##{id}"

        if level > last_level
          ((last_level + 1)..level).each do |l|
            idx = l - 2
            parent_idx = idx - 1
            unless list_stack[idx]
              parent_list = list_stack[parent_idx] || list_stack.last
              list_stack[idx] = parent_list.with_list
            end
          end
        elsif level < last_level
          list_stack = list_stack[0..(level - 2)]
        end

        last_level = level
        current_list = list_stack[level - 2] || list_stack.last
        current_list.with_link(
          title,
          path,
          data: {
            scrollspy_target: "link",
            action: "click->scrollspy#scrollTo",
          },
        )
      end
    end

    # Custom Kramdown HTML converter that outputs headers with TOC/scrollspy structure.
    class TocConverter < Kramdown::Converter::Html
      def convert_header(el, _indent)
        view = @options[:view_context]
        typography = @options[:typography]
        level = el.options[:level]
        title = el.options[:raw_text].to_s
        id = title.parameterize.presence || "section"

        css_class = if typography
          RapidUI.merge_classes("typography-h#{level}", "toc-trigger")
        else
          "toc-trigger"
        end

        if level >= 2
          content = view.safe_join([
            view.link_to(title, "##{id}", data: { action: "click->scrollspy#scrollTo" }),
            view.link_to("#", "##{id}", class: "toc-trigger-link"),
          ])
          view.tag.send(:"h#{level}", content, id: id, class: css_class, data: { scrollspy_target: "trigger" })
        else
          h1_class = typography ? "typography-h1" : nil
          view.tag.h1(title, id: id, class: h1_class)
        end
      end
    end
  end
end
