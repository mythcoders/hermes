# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :client

  scope :active, -> { where(active: true) }

  validates_presence_of :client, :name
  validates_presence_of :sender_name, :sender_address, :html_body, :text_body, if: :active

  def sender
    "#{sender_name} <#{sender_address}>"
  end
end
