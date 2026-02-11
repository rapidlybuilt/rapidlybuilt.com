# Search

Provide a search box that filters table rows. The search query is read from the request and applied via the registered `search` filter. The Search extension is provided by `RapidUI::Datatable::Search`.

---

## Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_search` | Boolean | `false` | Disable search entirely (no search filter, no search control). |
| `search_param` | Symbol | `:q` | Request param name for the search query. |

---

### Class settings

```ruby
class UsersTable < RapidUI::Datatable::Base
  self.skip_search = false
  self.search_param = :q
end
```

The current query is available as `table.search_query` (from `params[search_param]`). Filtering is applied by the extension that implements `filter_search(scope)` (e.g. an adapter).

---

### Instance settings

You can override the class settings when building the table.

```ruby
UsersTable.new(
  @users,
  skip_search: false,
  search_param: :q
)
```

---

## Adapters

Support for search is available through these adapters:

* [ActiveRecord](/components/controls/datatables/active-record)
* [Array](/components/controls/datatables/array)


---

## Controls

The extension registers one control for use in the table UI.

### Search field form

Renders a form with a single search input. Submitting it sends the table’s param (e.g. `table`) plus `search_param` (e.g. `q`) and resets `page` to 1. Place it in a header group alongside other filters.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `url` | String, nil | `table.table_path(...)` | Form action URL. Omit to use the table’s current path. |
| `form_method` | Symbol | `:get` | HTTP method for the form. |

```ruby
table.build_header do |header|
  group.build_search_field_form
  # Or with options:
  # group.build_search_field_form(url: some_path, form_method: :get)
end
```

Placeholder text is taken from I18n: `t("rapid_ui.datatable.search.placeholder")` (e.g. `"Search..."`).
