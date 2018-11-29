# frozen_string_literal: true

module Hermes
  module KeyGenerator
    def self.new
      SecureRandom.urlsafe_base64(64)
    end
  end
end
