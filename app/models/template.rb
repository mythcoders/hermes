# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :client

  validates_presence_of :client, :name
  validates_presence_of :sender_name, :sender_address, :html_body, :text_body, if: :active
end
