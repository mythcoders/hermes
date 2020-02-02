# frozen_string_literal: true

# Takes a MessageID and sends the message to the approperate destination
class PostalWorker
  include Sidekiq::Worker

  def perform(_request_params)
    Rails.logger.debug 'Yikes'
  end
end
