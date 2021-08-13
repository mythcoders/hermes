# frozen_string_literal: true

class ClientEnvironment < ApplicationRecord
  belongs_to :client, inverse_of: :environments

  validates :name, presence: true, uniqueness: {scope: %i[client]}

  # approved: Messages are delivered without any filtering
  # hold: Messages are saved but not delivered
  # ignored: Messages are not saved but no error is returned
  # rejected: Messages are not saved and an error is returned
  # rerouted: Messages are sent to the Client owner
  # whitelisted: Messages are only delivered to recipeints whitelisted for the Client
  enum status: {
    approved: "approved",
    hold: "hold",
    ignored: "ignored",
    rejected: "rejected",
    rerouted: "rerouted",
    whitelisted: "whitelisted"
  }

  def fancy_name
    "#{name} (#{status})"
  end

  def self.find_or_create_by_env!(client, environment)
    where(client_id: client.id, regex: true).each do |env|
      return env if environment.match(env.name)
    end

    find_by!(client_id: client.id, name: environment, regex: false)
  rescue ActiveRecord::RecordNotFound
    create!(client_id: client.id, name: environment, status: :rerouted)
  end
end
