class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  retry_on ActiveRecord::Deadlocked

  # Automatically retry jobs that encountered an Exception similar to Sidekiq
  retry_on StandardError, wait: :exponentially_longer, attempts: 20

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
