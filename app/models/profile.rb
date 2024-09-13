class Profile < ApplicationRecord
  belongs_to :sender

  validates :name, presence: true, uniqueness: {scope: %i[sender]}

  # approved: Messages are delivered without any filtering
  # hold: Messages are saved but not delivered
  # ignored: Messages are not saved but no error is returned
  # rejected: Messages are not saved and an error is returned
  # rerouted: Messages are sent to the Sender owner
  # whitelisted: Messages are only delivered to recipeints whitelisted for the Sender
  enum :state, %w[approved hold ignored rejected rerouted whitelisted].index_by(&:itself), default: :hold

  def display_name
    "#{name} (#{status})"
  end

  # def self.find_or_create_by_env!(client_id, env_name)
  #   direct_match = find_or_initialize_by(client_id: client_id, name: env_name, regex: false)
  #   return direct_match if direct_match.persisted?

  #   where(client_id: client_id, regex: true).each do |env|
  #     return env if env_name.match(env.name)
  #   end

  #   direct_match.update!(status: :rerouted)
  #   direct_match
  # end
end
