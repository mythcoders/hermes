# frozen_string_literal: true

class MailingTopic < ApplicationRecord
  belongs_to :client
  has_many :subscriptions
end
