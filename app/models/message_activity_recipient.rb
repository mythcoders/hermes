# frozen_string_literal: true

class MessageActivityRecipient < ApplicationRecord
  belongs_to :message_recipient
  belongs_to :message_activity
end
