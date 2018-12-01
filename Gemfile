ruby '2.5.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'audited' # data audits
gem 'bootsnap', require: false
gem 'devise' # security
gem 'jbuilder', '~> 2.5' # JSON APIs https://github.com/rails/jbuilder
gem 'kaminari' # Pagination
gem 'logdna-rails' # Logging
# gem 'lograge'
gem 'pg' # database for Active Record
gem 'pinglish' # app status checking
gem 'puma' # app server
gem 'sentry-raven' # Exceptions
gem 'skylight'

# UI
gem 'bootstrap', '>= 4.1.2'
gem 'haml'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'sass-rails'
gem 'sprockets-rails'
gem 'turbolinks', '~> 5.0.1'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
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
  gem 'ruby-debug-ide'
  gem 'shoulda-matchers', '4.0.0.rc1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# group :test do
#   gem 'chromedriver-helper'
#   gem 'selenium-webdriver'
#   gem 'timecop'
# end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
