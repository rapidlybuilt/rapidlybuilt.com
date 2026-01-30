require "rouge"

module MarkdownHelper
  # Render markdown with table of contents sidebar integration
  # Uses the rapid_ui table_of_contents pattern
  def render_markdown_with_toc(text, typography: true)
    toc_renderer = TocRenderer.new(view_context: self, typography:)
    toc_renderer.render(text)
  end

  # Simple markdown rendering without TOC
  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, autolink: true)
    markdown.render(text).html_safe
  end

  def gem_readme(gem_name)
    gem_dir = Gem.loaded_specs[gem_name]&.gem_dir
    return nil unless gem_dir

    readme_path = File.join(gem_dir, "README.md")
    File.read(readme_path) if File.exist?(readme_path)
  end

  # Custom renderer that extracts headings and integrates with rapid_ui TOC
  class TocRenderer
    attr_reader :view_context, :typography

    delegate :ui, :tag, :link_to, :safe_join, :render, to: :view_context

    def initialize(view_context:, typography: true)
      @view_context = view_context
      @typography = typography
    end

    def render(text)
      # Set up the rapid_ui table of contents sidebar
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
      @toc = toc
      @list_stack = [toc]
      @last_level = 1

      # Render markdown with custom header handling
      renderer = HeaderRenderer.new(toc_renderer: self)
      markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, autolink: true)
      content_html = markdown.render(text).html_safe

      safe_join([
        # Inline TOC for mobile
        tag.div(
          safe_join([
            tag.h2(sidebar.title, class: "toc-inline-title"),
            @view_context.render(toc),
          ]),
          class: "toc-inline-container block lg:hidden",
        ),
        content_html,
      ])
    end

    def add_header_to_toc(level, title, id)
      path = "##{id}"

      if level > @last_level
        push_into_toc(level)
      elsif level < @last_level
        pop_out_of_toc(level)
      end

      @last_level = level
      current_list.with_link(
        title,
        path,
        data: {
          scrollspy_target: "link",
          action: "click->scrollspy#scrollTo",
        },
      )
    end

    def header_class(level)
      "typography-h#{level}" if typography
    end

    private

    def current_list
      @list_stack[@last_level - 2] || @list_stack.last
    end

    def push_into_toc(level)
      ((@last_level + 1)..level).each do |l|
        idx = l - 2
        parent_idx = idx - 1

        unless @list_stack[idx]
          parent_list = @list_stack[parent_idx] || @list_stack.last
          new_list = parent_list.with_list
          @list_stack[idx] = new_list
        end
      end
    end

    def pop_out_of_toc(level)
      index = level - 2
      @list_stack = @list_stack[0..index]
    end
  end

  # Custom Redcarpet renderer that hooks into TOC building and syntax highlighting
  class HeaderRenderer < Redcarpet::Render::HTML
    def initialize(toc_renderer:)
      @toc_renderer = toc_renderer
      super(hard_wrap: true)
    end

    def header(text, level)
      id = text.parameterize
      css_class = @toc_renderer.header_class(level)

      # Add to TOC (only h2 and deeper) - must happen before building HTML
      @toc_renderer.add_header_to_toc(level, text, id) if level >= 2

      class_attr = css_class ? %( class="#{css_class} toc-trigger") : ""
      data_attr = level >= 2 ? %( data-scrollspy-target="trigger") : ""

      # Must return a String for Redcarpet
      String.new(%(<h#{level} id="#{id}"#{class_attr}#{data_attr}>#{text}</h#{level}>))
    end

    def block_code(code, language)
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexer.find(language) || Rouge::Lexers::PlainText.new
      highlighted = formatter.format(lexer.lex(code))

      String.new(%(<pre class="code-theme-light highlight language-#{language}">#{highlighted}</pre>))
    end
  end
end
