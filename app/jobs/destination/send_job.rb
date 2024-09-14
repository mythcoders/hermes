class Message::SendJob < ApplicationJob
  def perform(id)
    Message.find(id).send_now
  end
end
