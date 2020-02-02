# frozen_string_literal: true

require 'sidekiq/pro/web'

redis_config = {
  url: ENV['REDIS_URL'],
  namespace: ENV['REDIS_WORKER_NAMESPACE'],
  network_timeout: 3
}

Sidekiq.default_worker_options = { retry: 3 }

Sidekiq.configure_server do |config|
  config.redis = redis_config
  config.reliable_scheduler!
  config.super_fetch!

  config.death_handlers << lambda { |job, ex|
    Raven.extra_context job_id: job['jid']
    Raven.extra_context job_class: job['class']
    Raven.capture_exception(ex)
  }
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq::Client.reliable_push!
Sidekiq::Extensions.enable_delay!
