class Profile < ApplicationRecord
  belongs_to :sender

  validates :name, presence: true, uniqueness: {scope: %i[sender]}

  # approved: Messages are delivered without any filtering
  # hold: Messages are saved but not delivered
  # ignored: Messages are not saved but no error is returned
  # rejected: Messages are not saved and an error is returned
  # rerouted: Messages are sent to the Sender owner
  # whitelisted: Messages are only delivered to recipeints whitelisted for the Sender
  enum :state, %w[approved hold ignored rejected rerouted whitelisted].index_by(&:itself), default: :rerouted

  def display_name
    "#{name} (#{status})"
  end

  def self.find_or_create_from_api(sender, profile_name)
    match = find_or_initialize_by(sender: sender, name: profile_name, regex: false)
    return match if match.persisted?

    where(sender: sender, regex: true).each do |profile|
      return profile if profile_name.match(profile.name)
    end

    match.save
    match
  end
end
