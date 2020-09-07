# frozen_string_literal: true

class Subscriber < ApplicationRecord
  belongs_to :client
  has_many :subscriptions
end