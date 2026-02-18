# Kaminari adapter

Use this adapter when your table is backed by a scope that supports [Kaminari](https://github.com/kaminari/kaminari) (e.g. an `ActiveRecord::Relation`).

```ruby
class UsersTable < RapidUI::Datatable::Base
  include RapidUI::Datatable::Adapters::Kaminari
  # ... columns, bulk actions, etc.
end
```

---

## Pagination

The adapter exposes the standard Kaminari methods for pagination: `total_pages`, `current_page`, and `total_records_count`. This allows your table to display pagination controls and choose how many records to show per page automatically.
