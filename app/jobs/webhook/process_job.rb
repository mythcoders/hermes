class Webhook::ProcessJob < ApplicationJob
  queue_as :webhooks

  def perform(id)
    Webhook.find(id).process_now
  end
end
