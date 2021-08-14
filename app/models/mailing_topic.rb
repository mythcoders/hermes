# frozen_string_literal: true

class MailingTopic < ApplicationRecord
  belongs_to :client
  has_many :subscriptions

  scope :active, -> { where(active: true) }

  validates_presence_of :client
  validates :name, presence: true, uniqueness: {scope: %i[client]}
end
