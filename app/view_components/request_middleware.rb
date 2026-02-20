class RequestMiddleware < RapidlyBuilt::Request::Middleware::Entry
  with_options to: :controller do
    delegate :gems_rapid_ui
  end

  def call
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

      head.stylesheet_link_sources = [ "console" ]
      head.skip_csrf_meta_tags = !dynamic_page?(context)
    end

    layout.build_header do |header|
      header.build_left do |left|
        # TODO: clean this up. #build_link with a single child (the icon)
        left.build_icon_link("logo", helpers.root_path, size: 32, class: "px-0 size-[34px]") do |link|
          link.body.first.css_class = "hover:scale-110 rounded-full"
        end

        left.build_search_bar(static_path: helpers.search_index_path)
      end

      header.build_right do |right|
        # TODO: active attribute when under each section
        right.build_text_link("Apps", helpers.apps_root_path, class: "hidden md:block", active: request.path.start_with?("/apps"))
        right.build_text_link("Modules", helpers.modules_root_path, class: "hidden md:block", active: request.path.start_with?("/modules"))
        right.build_text_link("Gems", helpers.gems_root_path, class: "hidden md:block", active: request.path.start_with?("/gems"))

        right.build_dropdown(align: "right", class: "block md:hidden", skip_caret: true) do |dropdown|
          dropdown.build_button(ui.factory.build(RapidUI::Icon, "menu")) # TODO: clean up this

          dropdown.build_menu do |menu|
            menu.build_item("Home", helpers.root_path)
            menu.build_item("Apps", helpers.apps_root_path, active: request.path.start_with?("/apps"))
            menu.build_item("Modules", helpers.modules_root_path, active: request.path.start_with?("/modules"))
            menu.build_item("Gems", helpers.gems_root_path, active: request.path.start_with?("/gems"))
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

    if request.path.start_with?("/apps")
      ui.layout.subheader.breadcrumbs.build_breadcrumb "Apps", helpers.apps_root_path
    elsif request.path.start_with?("/modules")
      ui.layout.subheader.breadcrumbs.build_breadcrumb "Modules", helpers.modules_root_path
    elsif request.path.start_with?("/gems")
      ui.layout.subheader.breadcrumbs.build_breadcrumb "Gems", helpers.gems_root_path
    end
  end

  private

  def dynamic_page?(context)
    [
      gems_rapid_ui.components_controls_datatables_path,
      gems_rapid_ui.bulk_action_components_controls_datatables_path,
    ].include?(context.request.path)
  end
end
