source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "~> 7.2"

gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"
gem "bcrypt"
gem "bootsnap", require: false
gem "geared_pagination"
gem "importmap-rails"
gem "mission_control-jobs"
gem "propshaft"
gem "puma"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "sqlite3"
gem "stimulus-rails"
gem "turbo-rails"
gem "view_component"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
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
