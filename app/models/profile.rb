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
end
