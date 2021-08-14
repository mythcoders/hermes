# frozen_string_literal: true

require_relative "boot"

require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "action_cable/engine"
# require 'action_mailbox/engine'
require "action_text/engine"
# require 'rails/test_unit/railtie'
require "sprockets/railtie"
require "view_component/engine"

require "pinglish"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hermes
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.encoding = "utf-8"
    config.time_zone = "Eastern Time (US & Canada)"
    config.beginning_of_week = :sunday
    config.public_file_server.enabled
    config.autoload_paths += %W[#{config.root}/lib]
    # config.require_master_key = true

    config.active_job.queue_adapter = :sidekiq

    # Storage
    config.active_storage.variant_processor = :vips
    config.active_storage.routes_prefix = "/storage"

    # Logging
    config.lograge.enabled = true
  end
end
