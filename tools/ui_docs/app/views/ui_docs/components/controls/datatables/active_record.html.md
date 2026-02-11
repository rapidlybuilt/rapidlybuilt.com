# ActiveRecord adapter

Use this adapter when your table is backed by an `ActiveRecord::Relation`. Include `RapidUI::Datatable::Adapters::ActiveRecord` in your table class and pass the relation as the first argument when building the table (e.g. `UsersTable.new(User.all, ...)`). The adapter provides search, sorting, batched export, and record IDs for bulk actions.

```ruby
class UsersTable < RapidUI::Datatable::Base
  include RapidUI::Datatable::Adapters::ActiveRecord
  # ... columns, bulk actions, etc.
end
```

---

## Search

The adapter implements `filter_search(scope)` by calling `scope.search(search_query)` on the relation. Your model must define a **class method or scope named `search`** that accepts the query string and returns a relation.

If the model does not respond to `search`, the adapter sets `skip_search = true` during initialization so the search UI is not shown and the filter is not applied.

```ruby
# On your model (e.g. User)
scope :search, ->(query) {
  return all if query.blank?
  where("name ILIKE :q OR email ILIKE :q", q: "%#{sanitize_sql_like(query)}%")
}
```

---

## Sorting

The adapter implements `filter_sorting(scope)` by applying `scope.reorder(nil).order(sort_column.id => sort_order)`. Sort column and order come from the table’s sorting extension (params or defaults).

Columns can set **`nulls_last: true`** so that nulls are ordered last (PostgreSQL-style `NULLS LAST`). The adapter then uses quoted column names and validates `sort_order` before interpolating into SQL.

```ruby
columns do |t|
  t.string :name, sortable: true
  t.datetime :signed_at, sortable: true, nulls_last: true
end
```

---

## Export

The adapter overrides **`each_record(batch_size:, &block)`** to use `records.unscope(:limit, :offset).find_each(batch_size:, &block)`. CSV and JSON export use this for batched iteration, so large exports don’t load the entire relation into memory.

---

## Record ID

The adapter implements **`record_id(record)`** as `record.send(record.class.primary_key)`. This value is used for bulk action checkboxes (so the correct rows are submitted), for row identification in Turbo updates, and anywhere the table needs a stable id for a record.
