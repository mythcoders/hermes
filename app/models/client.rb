# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :messages
  has_many :environments, class_name: 'ClientEnvironment', dependent: :destroy

  validates_length_of :name, :owner, maximum: 50
  validates_length_of :reroute_email, :reply_to_email, maximum: 60
  validates_length_of :api_secret, :api_key, maximum: 128
  validates_uniqueness_of :name, :api_secret, :api_key
  validates_presence_of :name, :owner, :reroute_email, :api_secret, :api_key

  def self.authenticate(key, secret)
    where(api_key: key, api_secret: secret).limit(1).first
  end

  def reroute_recipient
    MessageRecipient.new(email: "#{owner} <#{reroute_email}>", recipient_type: :to)
  end
end
