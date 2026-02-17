# Bulk actions

Let users select rows via checkboxes and run an action on the selected set (e.g. delete, archive). The extension adds a leading “select” column (select-all header + per-row checkboxes) and a header control (dropdown of actions + submit button).

---

## Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_bulk_actions` | Boolean | `false` | Disable bulk actions entirely (no select column, no header control). |
| `bulk_action_ids_param` | Symbol | `:ids` | Request param name for the list of selected record IDs (e.g. `ids[]`). |

Per bulk action (DSL):

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `id` | Symbol | — | Unique identifier for the action (required). |
| `label` | String, nil | `nil` | Display label; falls back to I18n `bulk_actions.<id>` then titleized id. |

---

### Class settings

Define bulk actions with `bulk_action` in your table class. If no actions are defined, `skip_bulk_actions` is set to true and the select column is not added.

```ruby
class UsersTable < RapidUI::Datatable::Base
  include RapidUI::Datatable::Extensions::BulkActions

  self.bulk_action_ids_param = :user_ids

  bulk_action :delete
  bulk_action :archive, label: "Archive Selected"
  bulk_action :export, label: "Export selected"

  columns do |t|
    t.integer :id
    t.string :name
    t.string :email
  end
end
```

Selected IDs are available as `table.selected_bulk_action_record_ids` (from `params[bulk_action_ids_param]`). Use `table.selected_bulk_action_record?(record)` to check if a record is selected. The select column is excluded from exports (`skip_export`). The controller must handle the bulk action (e.g. POST to an action that reads the chosen action and the IDs and performs the operation).

---

### Instance settings

You can override or narrow bulk actions when building the table. Pass `bulk_actions` (array of bulk action objects) or `bulk_action_ids` (symbols) to show only those actions.

```ruby
UsersTable.new(
  @users,
  skip_bulk_actions: false,
  bulk_action_ids: [:archive, :delete]
)
```

---

## Controls

The extension registers one control and automatically adds a select column when bulk actions are enabled.

### Action Select

Renders a select dropdown (one option per bulk action) and a submit button. On submit, the selected action and `bulk_action_ids_param` (e.g. `ids[]`) are sent to `table.table_path(action: :bulk_action)` (POST). Typically placed in the table header.

```ruby
table.build_header do |header|
  header.build_bulk_actions(table:, class: "datatable-bulk-actions-select-container")
end
```

Labels use I18n: `t("rapid_ui.datatable.bulk_actions.<id>")` per action; placeholder and button use `t("rapid_ui.datatable.bulk_actions.placeholder")`, `t("rapid_ui.datatable.bulk_actions.button")`, and `t("rapid_ui.datatable.bulk_actions.button_title")`. The dropdown and submit are wired with Stimulus for `toggleBulkActionPerform` and `submitBulkAction`.

### Select checkboxes

When `skip_bulk_actions?` is false and at least one bulk action is defined, the extension inserts a leading column: the header cell is a “select all” checkbox and each row cell is a checkbox for that record. Values use `table.row_id(row)` (e.g. `record.id`). The column is excluded from CSV/JSON exports.
