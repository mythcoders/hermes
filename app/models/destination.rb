class Destination < ApplicationRecord
  include WithUuid
  include Bannable
  include Sendable

  has_many :activities

  encrypts :address, deterministic: true
  enum :address_type, %w[to cc bcc].index_by(&:itself), default: :to
end
