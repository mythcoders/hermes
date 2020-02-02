# frozen_string_literal: true

class MessageActivity < ApplicationRecord
  ACTIVITY_TYPES = %i[received rerouted delivered opened click bounced blocked scheduled sent].freeze

  belongs_to :message
end
