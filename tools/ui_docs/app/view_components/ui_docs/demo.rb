# Copied from RapidUI | Source: rapid_ui/docs/app/view_components/demo.rb
module UiDocs
  class Demo < ApplicationComponent
    attr_accessor :html

    attr_accessor :erb_code
    attr_accessor :ruby_code
    attr_accessor :html_code

    attr_accessor :current_tab

    attr_accessor :content_class

    def initialize(html: nil, erb_code: nil, ruby_code: nil, html_code: nil, content_class: nil, **kwargs)
      super(**kwargs)

      @html = html

      @erb_code = erb_code
      @ruby_code = ruby_code
      @html_code = html_code

      @content_class = content_class
      @current_tab = erb_code ? "erb" : (ruby_code ? "ruby" : "html")
    end

    def stimulus_controller_name
      "tabs" if [ erb_code, ruby_code, html_code ].compact.length > 1
    end

    def tab_button(code, label, panel_id)
      disabled = !code

      css = "demo-code-tab"
      css += " active" if current_tab == panel_id
      css += " disabled" unless code

      button_tag(
        label,
        class: css,
        data: disabled ? {} : {
          tabs_target: "tab",
          panel_id:, action: "click->tabs#switch",
        },
      )
    end

    def tab_panel(code, panel_id)
      return unless code

      css = "demo-code-panel"
      css += " hidden" unless current_tab == panel_id
      tag.div(render(code), class: css, data: { panel_id:, tabs_target: "panel" })
    end

    private

    def generate_tabbed_code(erb_code, ruby_code)
      tabs = tag.div(class: "demo-code-tabs") do
        safe_join([
          tag.button("ERB",
            class: "demo-code-tab active",
            data: {
              demo_tabs_target: "tab",
              panel_id: "erb",
              action: "click->demo-tabs#switchTab",
            }
          ),
          tag.button("Ruby",
            class: "demo-code-tab",
            data: {
              demo_tabs_target: "tab",
              panel_id: "ruby",
              action: "click->demo-tabs#switchTab",
            }
          ),
        ])
      end

      tag.div(tabs + content, class: "demo-code")
    end
  end
end
