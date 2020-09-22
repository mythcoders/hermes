# frozen_string_literal: true

class Subscriber < ApplicationRecord
  belongs_to :client
  has_many :subscriptions

  validates_presence_of :client
  validates :address, presence: true, uniqueness: { scope: %i[client] }

  def formatted_address
    "#{name} <#{address}>"
  end
end
