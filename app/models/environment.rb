class Environment < ApplicationRecord
  belongs_to :client

  validates :name, presence: true, uniqueness: {scope: %i[client]}

  # approved: Messages are delivered without any filtering
  # hold: Messages are saved but not delivered
  # ignored: Messages are not saved but no error is returned
  # rejected: Messages are not saved and an error is returned
  # rerouted: Messages are sent to the Client owner
  # whitelisted: Messages are only delivered to recipeints whitelisted for the Client
  enum :state, %w[approved hold ignored rejected rerouted whitelisted].index_by(&:itself), default: :hold
end
