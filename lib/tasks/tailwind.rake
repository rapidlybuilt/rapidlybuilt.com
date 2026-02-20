# Run Tailwind builds before assets:precompile so built CSS is included.
namespace :tailwind do
  task :build do
    exit 1 unless system("./bin/rapid tailwind build --target main")
    exit 1 unless system("./bin/rapid tailwind build --target console")
  end
end

Rake::Task["assets:precompile"].enhance(["tailwind:build"])
