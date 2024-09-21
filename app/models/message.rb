class Message < ApplicationRecord
  include WithUuid
  include DeliveryStats

  belongs_to :sender
  has_many :recipients, dependent: :destroy

  encrypts :html_body
  encrypts :text_body

  def halted?
    halted_at.present?
  end
end
