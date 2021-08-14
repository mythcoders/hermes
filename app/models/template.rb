# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :client

  scope :active, -> { where(active: true) }

  validates_presence_of :client
  validates_presence_of :sender_name, :sender_address, :html_body, :text_body, if: :active
  validates :name, presence: true, uniqueness: {scope: %i[client]}

  def sender
    "#{sender_name} <#{sender_address}>"
  end
end
