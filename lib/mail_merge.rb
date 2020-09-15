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
      hubble_url: Hubble.env_url,
      unsubscribe_url: subscription_url,
      volunteer_registration_url: volunteer_registration_url
    }
  end

  def contact_fields
    {
      contact_first_name: person.first_name.humanize,
      contact_last_name: person.last_name.humanize,
      contact_email: recipient.email_address.address
    }
  end

  def person
    @person ||= recipient.email_address.person
  end

  def committee_base_url
    "#{Hubble.env_url}/committees/#{committee.registration_token}/"
  end

  def subscription_url
    "#{committee_base_url}/subscriptions/#{subscription_id}?tracking_id=#{tracking_id}"
  end

  def subscription_id
    @subscription_id ||=
      EmailSubscription.find_by(
        email_address_id: recipient.email_address_id,
        committee_id: committee.id
      )&.identifier
  end

  def tracking_id
    @tracking_id ||= recipient.email_transaction.tracking_id
  end
end
