# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :mailing_topic
  belongs_to :subscriber
end