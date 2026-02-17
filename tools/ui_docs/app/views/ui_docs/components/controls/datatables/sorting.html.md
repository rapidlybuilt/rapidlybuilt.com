# Sorting

Control which columns are sortable and how sort column/order are read from the request. Clicking a sortable column header updates the URL params and applies the registered `sorting` filter. The Sorting extension is provided by `RapidUI::Datatable::Sorting`.

---

## Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_sorting` | Boolean | `false` | Disable sorting entirely (no filter, headers render as plain labels). |
| `sort_column_param` | Symbol | `:sort` | Request param for the column to sort by. |
| `sort_order_param` | Symbol | `:dir` | Request param for the order (`asc` or `desc`). |
| `sort_column` | Symbol, nil | `nil` | Default column to sort by (must be a sortable column id). |
| `sort_order` | String | `"asc"` | Default sort order. |

Column-level (per column):

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `sortable` | Boolean | `false` | Whether this column is sortable. |
| `sort_order` | String | `"asc"` | Default order when first clicking this column. |

---

### Class settings

```ruby
class UsersTable < RapidUI::Datatable::Base
  self.skip_sorting = false
  self.sort_column_param = :sort
  self.sort_order_param = :dir
  self.sort_column = :name
  self.sort_order = "asc"

  columns do |t|
    t.integer :id
    t.string :name, sortable: true, sort_order: "asc"
    t.string :email, sortable: true, sort_order: "desc"
    t.datetime :created_at
  end
end
```

Current sort is available as `table.sort_column` (the column object or nil) and `table.sort_order` (`"asc"` or `"desc"`). Filtering is applied by the extension that implements `filter_sorting(scope)` (e.g. an adapter). Invalid param values (unknown column or order) are ignored and defaults are used.

---

### Instance settings

You can override the class settings when building the table.

```ruby
UsersTable.new(
  @users,
  skip_sorting: false,
  sort_column: :name,
  sort_order: "asc"
)
```

Column groups can define their own default `sort_column` and `sort_order`; the initializer copies those onto the config when a `column_group_id` is set.

---

## Adapter

Support for sorting is available through these adapters:

* [ActiveRecord](action: active_record)
* [Array](action: array)

---

## Controls

Sorting does not register a separate control. Sortable columns are rendered as clickable header links with ▲/▼ icons.
