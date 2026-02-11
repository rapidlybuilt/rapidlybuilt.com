# Columns

Define which columns appear in the table, their headers, and how cell values are rendered. The Columns extension is provided by `RapidUI::Datatable::Columns`.

---

## Defining columns

Use the `columns do |t|` block to define the columns in your datatable.

```ruby
class UsersTable < RapidUI::Datatable::Base
  columns do |t|
    t.integer :id
    t.string :name
    t.string :email
    t.datetime :created_at
  end
end
```

---

## Labels

Set a custom header label with `label:` on the type call.

```ruby
class UsersTable < RapidUI::Datatable::Base
  columns do |t|
    t.integer :id, label: "ID"
    t.string :name, label: "Full Name"

    # Defaults to t(:columns, :email) or "Email"
    t.string :email
  end
end
```

---

## Column types

Use `column_type` to define a custom types for your application.

```ruby
class UsersTable < RapidUI::Datatable::Base
  column_type :account, :html do |account|
    link_to(account.name, account_path(account))
  end

  columns do |t|
    t.string :id
    t.string :name
    t.account :account
  end

  delegate :link_to, :account_path, to: :helpers
end
```

---

## Column groups

Define a named subset of columns with `column_group`. When building the table, pass `column_group_id:` to show only those columns.

```ruby
class UsersTable < RapidUI::Datatable::Base
  columns do |t|
    t.integer :id
    t.string :name
    t.string :email
    t.datetime :created_at
  end

  # "Basic" view: only name and email
  column_group :basic, [:name, :email]
  # Default group includes all columns when no column_group_id is set
end
```

In the controller or view, use the group when building the table:

```ruby
# Show only columns in the :basic group
rapid_table(@users, table_class: UsersTable, column_group_id: :basic)
```

---

## Cell content

Override how a column’s cell is rendered with `column_html` (HTML) or `column_value` (plain value). The block receives `(record, column)` or just `(record)`.

```ruby
class UsersTable < RapidUI::Datatable::Base
  columns do |t|
    t.integer :id
    t.string :name
    t.string :email
  end

  delegate :mail_to, to: :helpers

  # Custom HTML for the email column (e.g. mailto link, styling)
  column_html :email do |record|
    mail_to record.email.downcase
  end

  # Custom value only; block can take (record) or (record, column)
  column_value :name do |record|
    record.name.strip
  end
end
```

---

## Toggle Columns

You can resolve columns from the DSL with `column_ids` or `column_group_id`, and then narrow with `only` or `except`.

```ruby
# Use specific column IDs from the table’s DSL (order is preserved)
rapid_table(@users, table_class: UsersTable, column_ids: [:name, :email, :id])

# Use a column group
rapid_table(@users, table_class: UsersTable, column_group_id: :basic)

# Include only these columns (filters the resolved list)
rapid_table(@users, table_class: UsersTable, only: [:name, :email])

# Exclude these columns (filters the resolved list)
rapid_table(@users, table_class: UsersTable, except: [:created_at])
```

You cannot use both `column_ids` and `column_group_id` at once.

---

## Raw Columns

Instead of the DSL, you can pass a `columns` array of hashes. You must specify at least one of `columns`, `column_ids`, or `column_group_id`.

```ruby
# Hashes: id required, label and method options optional
rapid_table(@users, table_class: UsersTable, columns: [
  { id: :id, label: "ID" },
  { id: :name, label: "Full Name" },
  { id: :email, html_cell_method: :formatted_email }
])
```
