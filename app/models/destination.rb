class Destination < ApplicationRecord
  include WithUuid
  include Bannable
  include Sendable

  has_many :activities, dependent: :destroy

  encrypts :address, deterministic: true
  enum :address_type, %w[to cc bcc].index_by(&:itself), default: :to

  scope :unsent, -> { where(sent_at: nil) }
  scope :sent, -> { where.not(sent_at: nil) }
  scope :delivered, -> { where.not(delivered_at: nil) }
  scope :opened, -> { where.not(opened_at: nil) }
  scope :clicked, -> { where.not(clicked_at: nil) }
  scope :unopened, -> { where(opened_at: nil) }
  scope :bounced, -> { where.not(bounced_at: nil) }
  scope :complained, -> { where.not(complained_at: nil) }
end
