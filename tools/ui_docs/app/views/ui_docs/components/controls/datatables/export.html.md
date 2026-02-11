# Export

Export table data as CSV or JSON. The table responds to requests with `format: :csv` or `format: :json` and streams or returns the current filtered/sorted data. The Export extension is provided by `RapidUI::Datatable::Export`.

---

## Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_export` | Boolean | `false` | Disable export entirely (no export control, no format handling). |
| `csv_column_separator` | String | `","` | Separator used in CSV output. |
| `export_batch_size` | Integer | `1000` | Records per batch when iterating for export (used by `each_record`). |
| `export_formats` | Array&lt;Symbol&gt; | `[:csv, :json]` | Formats to offer (links are generated for each). Empty array disables export. |

Column-level (per column):

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_export` | Boolean | `false` | Exclude this column from CSV and JSON exports. |
| `export_method` | Symbol, nil | — | Method used for both CSV and JSON when set. |
| `csv_method` | Symbol, nil | — | Method used for CSV only (falls back to `export_method` then `value_method`). |
| `json_method` | Symbol, nil | — | Method used for JSON only (falls back to `export_method` then `value_method`). |

---

### Class settings

```ruby
class UsersTable < RapidUI::Datatable::Base
  self.skip_export = false
  self.csv_column_separator = ","
  self.export_batch_size = 500
  self.export_formats = %i[csv json]

  columns do |t|
    t.integer :id
    t.string :name
    t.string :email
    t.datetime :created_at
  end

  # Custom value for both CSV and JSON
  column_export :email do |record, column|
    record.email.downcase
  end

  # Format only for CSV
  column_csv :name do |record, column|
    record.name.strip
  end

  # Format only for JSON
  column_json :created_at do |record, column|
    record.created_at&.iso8601
  end
end
```

Export uses `export_columns` (columns with `skip_export?` false), `base_scope`, and `each_record(batch_size: export_batch_size)`; adapters or extensions must provide those. To exclude a column from exports, set `skip_export: true` on it in the columns DSL (e.g. `t.datetime :created_at, skip_export: true`). CSV is streamed via `stream_csv(stream)`; JSON is returned from `to_json`. If `export_formats` is empty, `skip_export` is set to true in the initializer.

---

### Instance settings

You can override the class settings when building the table.

```ruby
UsersTable.new(
  @users,
  skip_export: false,
  export_formats: [:csv],
  export_batch_size: 500
)
```

---

## Adapters

Optimized export capabilities provided by the following adapters:

* [ActiveRecord](/components/controls/datatables/active-record)

---

## Controls

The extension registers one control for use in the table UI.

### Exports links

Renders a title and one link per format in `table.export_formats`. Each link points to `table.table_path(format: format)` (e.g. same URL with `?format=csv` or `format=csv` in the path depending on routing). Typically placed in the footer.

```ruby
table.build_footer do |footer|
  footer.build_export_links
  # Or with extra options (e.g. class) passed to the container:
  # footer.build_exports(class: "my-exports")
end
```

Link labels come from I18n: `t("rapid_ui.datatable.export.formats.csv")`, `t("rapid_ui.datatable.export.formats.json")`, etc. The container title uses `t("rapid_ui.datatable.export.container.title")`.
