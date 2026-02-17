# Copied from RapidUI | Source: rapid_ui/docs/app/view_components/demo.rb
module UiDocs
  class Demo < ApplicationComponent
    Tab = Struct.new(:id, :label, :code, :current, keyword_init: true)

    attr_accessor :html
    attr_accessor :tabs
    attr_accessor :current_tab
    attr_accessor :content_class

    def initialize(html: nil, tabs: [], content_class: nil, **kwargs)
      super(**kwargs)

      @html = html
      @tabs = tabs
      @content_class = content_class
      @current_tab = tabs.find { |t| t.current }&.id || tabs.find { |t| t.code }&.id || tabs.first&.id
    end

    def stimulus_controller_name
      "tabs" if tabs.count { |t| t.code } > 1
    end

    def tab_button(tab)
      disabled = !tab.code

      css = "demo-code-tab"
      css += " active" if current_tab == tab.id
      css += " disabled" unless tab.code

      button_tag(
        tab.label,
        class: css,
        data: disabled ? {} : {
          tabs_target: "tab",
          panel_id: tab.id,
          action: "click->tabs#switch",
        },
      )
    end

    def tab_panel(tab)
      return unless tab.code

      css = "demo-code-panel"
      css += " hidden" unless current_tab == tab.id
      tag.div(render(tab.code), class: css, data: { panel_id: tab.id, tabs_target: "panel" })
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
