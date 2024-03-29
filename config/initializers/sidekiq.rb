# frozen_string_literal: true

require "sidekiq"
require "sidekiq-scheduler"

redis_config = {
  url: ENV["REDIS_URL"],
  namespace: ENV["REDIS_WORKER_NAMESPACE"],
  network_timeout: 3
}

Sidekiq.configure_server do |config|
  config.redis = redis_config

  # https://github.com/mperham/sidekiq/issues/4496#issuecomment-677838552
  config.death_handlers << ->(job, exception) do
    worker = job["wrapped"].safe_constantize
    worker&.sidekiq_retries_exhausted_block&.call(job, exception)
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq.default_worker_options = {retry: 3}
