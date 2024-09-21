class Recipient::SendJob < ApplicationJob
  def perform(id)
    Recipient.find(id).send_now
  end
end
