# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "aasm"
gem "aws-sdk-s3", require: false
gem "aws-sdk-sns", "~> 1"
gem "bootsnap", require: false
gem "devise" # security
gem "haml"
gem "hotwire-rails"
gem "jbuilder" # JSON APIs https://github.com/rails/jbuilder
gem "kaminari" # Pagination
gem "lograge"
gem "liquid" # template rendering
gem "paper_trail"
gem "pg" # database for Active Record
gem "pinglish" # app status checking
gem "puma" # app server
gem "rails", "~> 6.0.0"
gem "ransack" # Searching
gem "sass-rails"
gem "uglifier", ">= 1.3.0"
gem "view_component", require: "view_component/engine"
gem "webpacker"

# sentry exceptions
gem "sentry-rails"
gem "sentry-ruby"
gem "sentry-sidekiq"

# Sidekiq
gem "redis-namespace"
gem "sidekiq"
gem "sidekiq-scheduler"

source "https://rubygems.pkg.github.com/mythcoders" do
  gem "hermes"
end

group :development, :test do
  gem "better_errors"
  gem "bundler-audit"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara"
  gem "debase", "~> 0.2.5.beta2"
  gem "factory_bot_rails"
  gem "faker"
  gem "guard-rspec"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "ruby-debug-ide"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "standard"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "chromedriver-helper"
  gem "selenium-webdriver"
  gem "timecop"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
