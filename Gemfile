source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1"

gem "bcrypt"
gem "bootsnap", require: false
gem "importmap-rails"
gem "propshaft"
gem "litestack"
gem "puma", ">= 5.0"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "view_component"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "annotate"
  gem "debug", platforms: %i[mri windows]
  gem "dotenv-rails"
  gem "standard"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
