# frozen_string_literal: true

class ClientUpload < ApplicationRecord
  include AASM
  after_create :process_upload

  belongs_to :client, inverse_of: :uploads
  has_one_attached :data_file

  validates_presence_of :client, :file_type

  enum file_type: {
    subscriber: 'subscriber'
  }

  aasm column: :status do
    state :created, initial: true
    state :running, :errored, :finished

    event :start do
      transitions from: %i[created], to: :running
    end

    event :error do
      transitions from: %i[running created], to: :errored
    end

    event :finish do
      transitions from: %i[running errored], to: :finished
    end
  end

  private

  def process_upload
    ClientUploadWorker.perform_async id
  end
end
