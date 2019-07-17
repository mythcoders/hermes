# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails'

gem 'audited' # data audits
gem 'bootsnap', require: false
gem 'devise' # security
gem 'jbuilder', '~> 2.5' # JSON APIs https://github.com/rails/jbuilder
gem 'kaminari' # Pagination
gem 'lograge'
gem 'pg' # database for Active Record
gem 'pinglish' # app status checking
gem 'puma' # app server
gem 'sentry-raven' # Exceptions
gem 'skylight'

# UI
gem 'bootstrap'
gem 'haml'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'sass-rails'
gem 'sprockets-rails'
gem 'turbolinks', '~> 5.0.1'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'better_errors'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'debase'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'ruby-debug-ide'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
  gem 'timecop'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
