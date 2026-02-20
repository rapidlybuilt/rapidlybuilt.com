# Pagination

Control how table data is split across pages and how page/per-page are read from the request.

---

## Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_pagination` | Boolean | `false` | Disable pagination entirely. |
| `per_page` | Integer | — | Default records per page (must be in `available_per_pages`). |
| `available_per_pages` | Array&lt;Integer&gt; | `[25, 50, 100]` | Options offered in the per-page control. |
| `pagination_siblings_count` | Integer | `4` | Number of page links shown around the current page. |
| `page_param` | Symbol | `:page` | Request param for the current page. |
| `per_page_param` | Symbol | `:per` | Request param for records per page. |

---

### Class settings

```ruby
class UsersTable < RapidUI::Datatable::Base
  self.skip_pagination = false
  self.per_page = 25
  self.available_per_pages = [10, 25, 50, 100]
  self.page_param = :page
  self.per_page_param = :per
end
```

If `per_page` is omitted or not in `available_per_pages`, the first value in `available_per_pages` is used. The current page and per-page values are taken from request params (`page_param` and `per_page_param`), with defaults applied when missing or invalid.

---

### Instance settings

You can override the class settings with instance settings.

```ruby
UsersTable.new(
  @users,
  per_page: 25,
  available_per_page: [25, 50, 100]
)
```

---

## Controls

The extension registers two controls for use in the table UI.

### PerPage Select

Allows adjusting how many rows at present on the table

```ruby
table.build_footer do |footer|
  footer.build_per_page_select
end
```

### Pagination Links

Allows navigating between pages using a list of links like `First Prev 1 2 3 4 [5] 6 7 8 9 Next Last`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `siblings_count` | Integer | 4 | How many siblings to show on either side of the current page. |

```ruby
table.build_footer do |footer|
  footer.build_pagination_links
end
```
