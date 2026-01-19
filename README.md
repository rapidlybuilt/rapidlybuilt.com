# Rapidly Built — Static Site

A Rails-powered static site generator. Develop with the full Rails experience, then bake it down to static HTML/CSS/JS for deployment.

## Stack

- **Rails 8.1** with Propshaft
- **Hotwire** (Turbo + Stimulus)
- **Tailwind CSS**
- **Importmaps** for JavaScript
- **BakingRack** for static site generation & S3 deployment

## Development

```bash
bin/setup
```

This installs dependencies and starts the dev server at [localhost:3000](http://localhost:3000).

To start the server manually:

```bash
bin/dev
```

## Building the Static Site

```bash
bundle exec baking_rack build
```

Output goes to `_site/`.

## Deploying

Push to `staging` or `main` branch to trigger GitHub Actions deployment:

```bash
bin/push staging   # Deploy to staging
bin/push main      # Deploy to production
```

## Testing & CI

Run the full CI suite locally:

```bash
bin/ci
```

This runs:
- RuboCop style checks
- Bundler audit (gem vulnerabilities)
- Importmap audit
- Brakeman security analysis
- Rails tests
- System tests

## Project Structure

```
app/
├── views/pages/     # Static pages (home, error pages)
├── javascript/      # Stimulus controllers
└── assets/
    └── tailwind/    # Tailwind styles
_site/               # Built static output (gitignored)
config/
└── initializers/
    └── baking_rack.rb  # Static routes configuration
```
