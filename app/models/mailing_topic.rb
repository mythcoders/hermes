# frozen_string_literal: true

class MailingTopic < ApplicationRecord
  belongs_to :client
  has_many :subscriptions

  scope :active, -> { where(active: true) }

  validates_presence_of :client, :name
end
