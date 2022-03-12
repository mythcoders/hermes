# frozen_string_literal: true

Rails.application.configure do
  config.hosts << "hermes.mythcoders.dev"
  config.cache_classes = false

  config.eager_load = false
  config.log_level = :debug

  config.consider_all_requests_local = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.preview_path = "#{Rails.root}/spec/mailer_previews"
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {
    host: ENV["ENVIRONMENT_URL"]
  }
  config.action_mailer.smtp_settings = {
    user_name: Rails.application.credentials.dig(:email, :username),
    password: Rails.application.credentials.dig(:email, :password),
    domain: "mythcoders.com",
    address: "email-smtp.us-east-1.amazonaws.com",
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.active_support.deprecation = :log
  config.active_storage.service = :local
  # config.active_storage.service = :amazon
  config.active_record.migration_error = :page_load
  config.assets.debug = false
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
