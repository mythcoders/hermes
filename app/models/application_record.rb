# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  ACTIVITY_TYPES = %i[received rerouted processed sent delivered failed error clicked].freeze
  RECIPIENT_TYPES = %i[to cc bcc].freeze

  self.abstract_class = true
end
