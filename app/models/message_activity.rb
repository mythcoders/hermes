# frozen_string_literal: true

class MessageActivity < ApplicationRecord
  belongs_to :message
  has_many :message_activity_recipients
  has_many :recipients, through: :message_activity_recipients, source: :message_recipient

  def recipient
    recipients.first
  end
end
