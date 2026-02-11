# Copied from RapidUI | Source: rapid_ui/docs/app/helpers/components/controls/datatables_helper.rb
module UiDocs
  module Components::Controls::DatatablesHelper
    def component_controls_datatables_full_example
      render ui.build(
        Demo,
        html: render(@full_example_table),
        tabs: [
          Demo::Tab.new(id: "table", label: "Table", code: CodeBlock.build_from_constant(CountriesTable, factory: ui.factory), current: true),
          Demo::Tab.new(id: "model", label: "Model", code: CodeBlock.build_from_constant(Country, factory: ui.factory)),
          # TODO: extract the source from the controller methods directly
          Demo::Tab.new(id: "controller", label: "Controller", code: CodeBlock.build_from_constant(controller.class, factory: ui.factory)),
          Demo::Tab.new(id: "view", label: "View", code: CodeBlock.new(%(render @countries_table), language: "ruby", factory: ui.factory)),
        ],
      )
    end
  end
end
