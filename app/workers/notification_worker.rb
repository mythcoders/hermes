# frozen_string_literal: true

class NotificationWorker
  include Sidekiq::Worker

  def perform(_request_params)
    Rails.logger.debug 'Yikes'
  end
end
