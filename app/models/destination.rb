class Destination < ApplicationRecord
  include WithUuid
  include Bannable
  include Deliverable

  encrypts :address, deterministic: true
  enum :address_type, %w[to cc bcc].index_by(&:itself), default: :to
end
