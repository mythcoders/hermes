# frozen_string_literal: true

require 'csv'

module BulkUpload
  class SubscriberImporter
    def self.process(input)
      new(input).process
    end

    def initialize(data)
      @row = CSV.parse(data)[0]
    end

    def process
      if subscriber.new_record? || subscriber.name != row[1]
        update_subscriber_name
        subscriber.save!
      end

      return unless subscription.new_record?

      set_subscription_status
      subscription.save!
    end

    private

    attr_reader :row

    def mailing_topic
      @mailing_topic ||= MailingTopic.find row[0]
    end

    def subscriber
      @subscriber ||= Subscriber.find_or_initialize_by(
        client_id: mailing_topic.client_id,
        address: row[2]
      )
    end

    def subscription
      @subscription ||= Subscription.find_or_initialize_by(
        mailing_topic_id: mailing_topic.id,
        subscriber_id: subscriber.id
      )
    end

    def set_subscription_status
      subscription.status = :active
      subscription.identifier = SecureRandom.uuid
    end

    def update_subscriber_name
      subscriber.name = row[1]
    end
  end
end
