# frozen_string_literal: true

class MessageRecipient < ApplicationRecord
  RECIPIENT_TYPES = %i[to cc bcc].freeze

  belongs_to :message
  has_many :message_activity_recipients
  has_many :activities, through: :message_activity_recipients, source: :message_activity

  def self.build_from_array(list, type)
    list.map do |item|
      new(email: item,
        recipient_type: type)
    end
  end
end
