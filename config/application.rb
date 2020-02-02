# frozen_string_literal: true

require_relative 'boot'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_record/railtie'
require 'action_view/railtie'
require 'pinglish'

Bundler.require(*Rails.groups)

module Hermes
  class Application < Rails::Application
    config.load_defaults 5.2

    config.encoding = 'utf-8'
    config.time_zone = 'Eastern Time (US & Canada)'
    config.public_file_server.enabled
    config.autoload_paths += %W[#{config.root}/lib]
    # config.require_master_key = true

    # Logging
    config.lograge.enabled = true
  end
end
