# Array adapter

Use this adapter when your table is backed by a plain Ruby array (or array-like collection).

```ruby
class UsersTable < RapidUI::Datatable::Base
  include RapidUI::Datatable::Adapters::Array
  # ... columns, etc.
end
```

---

## Search

The adapter implements `filter_search(scope)` by filtering the array in memory. Only columns marked **`searchable: true`** are considered; the adapter keeps records where any of those columns’ values (as strings) contain the search query, case-insensitive. If no columns are searchable or the query is blank, the scope is returned unchanged.

```ruby
columns do |t|
  t.integer :id
  t.string :name, searchable: true
  t.string :email, searchable: true
end
```

---

## Sorting

The adapter implements `filter_sorting(scope)` by sorting the array in Ruby: it uses the current sort column and order from the table’s sorting extension, compares values with `<=>`, and treats `nil` as larger than any value so nils appear at the end in both ascending and descending order. No database or SQL is involved.

---

## Pagination

The adapter paginates plain Ruby arrays automatically, so pagination controls work with in-memory collections.
