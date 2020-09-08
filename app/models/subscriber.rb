# frozen_string_literal: true

class Subscriber < ApplicationRecord
  belongs_to :client
  has_many :subscriptions

  validates_presence_of :client, :address
end
