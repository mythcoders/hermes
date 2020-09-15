# frozen_string_literal: true

class MailMerge
  def initialize(email_recipient)
    @recipient = email_recipient
  end

  def field_hash
    @field_hash ||= hermes_fields.merge(contact_fields)
  end

  private

  attr_reader :recipient

  def hermes_fields
    {
      hermes_url: Hermes.env_url,
      unsubscribe_url: subscription_url
    }
  end

  def contact_fields
    {
      contact_name: person.first_name.humanize,
      contact_email: recipient.email_address.address
    }
  end

  def subscription_url
    "#{Hermes.env_url}/subscriptions/#{subscription_id}?tracking_id=#{tracking_id}"
  end

  def subscription_id
    @subscription_id ||=
      Subscription.find_by(
        email_address_id: recipient.email_address_id,
        committee_id: committee.id
      )&.identifier
  end

  def tracking_id
    @tracking_id ||= recipient.email_transaction.tracking_id
  end
end
