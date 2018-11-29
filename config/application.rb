require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Hermes
  class Application < Rails::Application
    config.load_defaults 5.2

    # Email
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_caching = false
    ActionMailer::Base.smtp_settings = {
      user_name: Rails.application.credentials.email.username,
      password: Rails.application.credentials.email.password,
      domain: 'mythcoders.com',
      address: 'email-smtp.us-east-1.amazonaws.com',
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
    }
  end
end
