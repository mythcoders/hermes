# frozen_string_literal: true

class ClientUploadWorker
  include Sidekiq::Worker

  def perform(upload_id)
    @upload_id = upload_id
    return if client_upload.finished?

    client_upload.start! unless client_upload.running?

    data_stream.open do |file|
      IO.foreach(file) do |row|
        BulkUpload::SubscriberImporter.process(row)
      rescue StandardError => e
        Raven.capture_exception e
      end
    end

    client_upload.finish!
  end

  private

  def client_upload
    @client_upload ||= ClientUpload.find @upload_id
  end

  def data_stream
    @client_upload.data_file.blob
  end
end
