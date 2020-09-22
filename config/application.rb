# frozen_string_literal: true

require_relative 'boot'

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'view_component/engine'
require 'pinglish'

Bundler.require(*Rails.groups)

module Hermes
  class Application < Rails::Application
    config.load_defaults 5.2

    config.encoding = 'utf-8'
    config.time_zone = 'Eastern Time (US & Canada)'
    config.beginning_of_week = :sunday
    config.public_file_server.enabled
    config.autoload_paths += %W[#{config.root}/lib]
    # config.require_master_key = true

    config.active_storage.routes_prefix = '/storage'

    # Logging
    config.lograge.enabled = true
  end
end
