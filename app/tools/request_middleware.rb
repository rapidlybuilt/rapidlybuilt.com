class RequestMiddleware
  def call(context)
    ui = context.ui
    layout = context.layout
    request = context.request
    main_app = context.controller.main_app
    # view_context = context.view_context # no guarentee what's available inside of this

    # set nav links as active based on the current path
    ui.factory.register_polish! RapidUI::Layout::Sidebar::Navigation::Link, ->(link) do
      link.active = request.path == link.path
    end

    # pre-expand sections with active links
    ui.factory.register_polish! RapidUI::Layout::Sidebar::Navigation::Section, ->(section) do
      section.expanded = section.path == request.path || section.links.any?(&:active?) if section.expanded.nil?
    end

    # auto-set whether the sidebar is closed based on the cookie
    ui.factory.register_polish! RapidUI::Layout::Sidebar::Base, ->(sidebar) do
      sidebar.closed = context.cookies[sidebar.closed_cookie_name] == "1" if sidebar.closed.nil?
    end

    layout.build_head do |head|
      head.site_name = "Rapidly Built"
      head.charset = "utf-8"

      head.build_favicon("rapid_ui/favicon-32x32.png", type: "image/png", size: 32)
      head.build_favicon("rapid_ui/favicon-16x16.png", type: "image/png", size: 16)
      head.build_apple_touch_icon("rapid_ui/apple-touch-icon.png")

      head.stylesheet_link_sources = [ "tools" ]
    end

    layout.build_header do |header|
      header.build_left do |left|
        # TODO: clean this up. #build_link with a single child (the icon)
        left.build_icon_link("logo", main_app.root_path, size: 32, class: "px-0 size-[34px]") do |link|
          link.body.first.css_class = "hover:scale-110 rounded-full"
        end

        left.build_search_bar(static_path: main_app.search_api_path(format: :json))
      end

      header.build_right do |right|
        # TODO: active attribute when under each section
        right.build_text_link("Apps", main_app.apps_root_path, class: "hidden md:block")
        right.build_text_link("Tools", main_app.tools_root_path, class: "hidden md:block")

        right.build_dropdown(align: "right", class: "block md:hidden", skip_caret: true) do |dropdown|
          dropdown.build_button(ui.factory.build(RapidUI::Icon, "menu")) # TODO: clean up this

          dropdown.build_menu do |menu|
            menu.build_item("Home", main_app.root_path)
            menu.build_item("Applications", "#")
            menu.build_item("Tools", main_app.tools_root_path)
          end
        end
      end
    end

    main_sidebar = layout.build_sidebar(id: "main_sidebar")

    layout.build_subheader do |subheader|
      subheader.build_sidebar_toggle_button(target: main_sidebar)
      subheader.build_breadcrumbs
    end

    layout.build_footer do |footer|
      footer.build_left do |left|
      #   left.build_text_link("Feedback", "#", class: "pl-0 hidden md:block")
      #   left.build_dropdown(direction: "up", class: "block md:hidden") do |dropdown|
      #     dropdown.build_button("Legal")
      #     dropdown.build_menu do |menu|
      #       menu.build_item("Privacy", "#")
      #       menu.build_item("Terms", "#")
      #       menu.build_item("Cookie preferences", "#")
      #     end
      #   end
      end

      footer.build_right do |right|
        right.build_copyright(start_year: 2025, company_name: "Rapidly Built, Inc.")
        # right.build_text_link("Privacy", "#", class: "hidden md:block")
        # right.build_text_link("Terms", "#", class: "hidden md:block")
        # right.build_text_link("Cookie preferences", "#", class: "pr-0 hidden md:block")
      end
    end

    layout.with_main
    layout.with_main_container

    if request.path.start_with?("/tools")
      ui.layout.subheader.breadcrumbs.build_breadcrumb "Tools", main_app.tools_root_path
    elsif request.path.start_with?("/apps")
      ui.layout.subheader.breadcrumbs.build_breadcrumb "Apps", main_app.apps_root_path
    end
  end
end
