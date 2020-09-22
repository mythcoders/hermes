# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :topic, class_name: 'MailingTopic', foreign_key: 'mailing_topic_id'
  belongs_to :subscriber, autosave: true

  enum status: {
    inactive: 0,
    active: 1,
    paused: 2
  }

  validates_presence_of :topic, :status, :identifier
  validates :subscriber, presence: true, uniqueness: { scope: %i[topic] }
end
