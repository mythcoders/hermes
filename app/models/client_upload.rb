# frozen_string_literal: true

class ClientUpload < ApplicationRecord
  belongs_to :client, inverse_of: :uploads
  has_one_attached :data_file

  validates_presence_of :client, :file_type

  enum file_type: {
    subscriber: 'subscriber'
  }
end
