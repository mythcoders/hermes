# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :mail_logs

  validates_length_of :name, :owner, maximum: 50
  validates_length_of :reroute_email, maximum: 60
  validates_length_of :api_secret, :api_key, maximum: 128
  validates_uniqueness_of :name, :api_secret, :api_key
  validates_presence_of :name, :owner, :reroute_email, :api_secret, :api_key

  def self.authenticate(secret, key)
    Client.where('api_secret = ? AND api_key = ?', secret, key).limit(1).first
  end
end
