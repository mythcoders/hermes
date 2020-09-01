# frozen_string_literal: true

module NotificationHandlers
  class BounceHandler < BaseNotificationHandler
    def handle
      new_callback.tap do |callback|
        bounced_recipients.each do |bounced_recipient|
          recipient = transaction.recipients.find_by_email(bounced_recipient['emailAddress']).first
          next if recipient.nil?

          callback.email_callback_details << EmailCallbackDetail.new(
            recipient: recipient,
            status: bounced_recipient['status'],
            action: bounced_recipient['action'],
            diagnostic_code: bounced_recipient['diagnosticCode']
          )
        end

        callback.save!
      end
      end

    private

    def new_callback
      EmailCallback.new(callback_type: :bounce,
                        email_transaction: transaction,
                        callback_timestamp: timestamp,
                        bounce_type: bounce_type,
                        bounce_subtype: bounce_subtype,
                        feedback_id: feedback_id,
                        reporting_mta: reporting_mta)
    end

    def timestamp
      @timestamp ||= DateTime.parse aws_callback.message['bounce']['timestamp']
      end

    def bounce_type
      @bounce_type ||= aws_callback.message['bounce']['bounceType']
    end

    def bounce_subtype
      @bounce_subtype ||= aws_callback.message['bounce']['bounceSubType']
    end

    def reporting_mta
      @reporting_mta ||= aws_callback.message['bounce']['reportingMTA']
    end

    def bounced_recipients
      @bounced_recipients ||= aws_callback.message['bounce']['bouncedRecipients']
    end

    def feedback_id
      @feedback_id ||= aws_callback.message['bounce']['feedbackId']
    end
  end
end
