# Select filter

Add dropdown filters that narrow the table by a single value (e.g. status, category). Each filter is a select whose options come from a proc and whose selection is applied via a filter proc.

---

## Settings

There is no table-level switch to disable select filters; omit `select_filter` definitions if you don’t want any.

Per-filter definition:

| Option | Type | Description |
|--------|------|-------------|
| `filter_id` | Symbol | Unique id for the filter; the request param is `:"#{filter_id}_filter"` (e.g. `:status_filter`). |
| `options` | Proc | `->(scope) { ... }`. Called with `table.base_scope`; must return an array of values shown in the dropdown. |
| `filter` | Proc | `->(scope, value) { ... }`. Called when a value is selected; must return the filtered scope. |

---

### Class settings

Define filters with `select_filter` in your table class. Each definition registers the filter param and a filter method.

```ruby
class UsersTable < RapidUI::Datatable::Base
  include RapidUI::Datatable::SelectFilter::Container

  select_filter :status,
    options: ->(scope) { scope.distinct.pluck(:status).compact.sort },
    filter: ->(scope, value) { scope.where(status: value) }

  select_filter :role,
    options: ->(scope) { scope.distinct.pluck(:role).compact },
    filter: ->(scope, value) { scope.where(role: value) }

  columns do |t|
    t.integer :id
    t.string :name
    t.string :status
    t.string :role
  end
end
```

---

### Instance settings

Select filter definitions are class-level. At runtime you only control which filters are built in the UI. The selected value for each filter comes from the request params.

---

## Adapters

No adapters are necessary since the `options` and `filter` procs perform the ORM work themselves.

---

## Controls

The extension registers one control builder. You build one select per filter definition, usually in a header group alongside search.

### Select filter

```ruby
table.build_header do |header|
  # build all select filters defined by the table
  header.build_select_filters

  # or build a specific filter
  header.build_select_filter(:role)
end
```
