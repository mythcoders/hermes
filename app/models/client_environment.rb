# frozen_string_literal: true

class ClientEnvironment < ApplicationRecord
  belongs_to :client, inverse_of: :environments

  validates :name, presence: true, uniqueness: { scope: %i[client] }

  enum status: {
    rerouted: 'rerouted',
    whitelisted: 'whitelisted',
    approved: 'approved',
    rejected: 'rejected',
    hold: 'hold',
    ignored: 'ignored'
  }

  def fancy_name
    "#{name} (#{status})"
  end

  def self.find_or_create_by_env!(client, environment)
    find_by!(client_id: client.id, name: environment)
  rescue ActiveRecord::RecordNotFound
    create!(client_id: client.id, name: environment, status: :rerouted)
  end
end
