# frozen_string_literal: true

# Takes a MessageID and begins inital sorting of the message
class MailSortWorker
  include Sidekiq::Worker

  def perform(_message_id)
    Rails.logger.debug 'Yikes'
  end
end
