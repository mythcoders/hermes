class Ban < ApplicationRecord
  normalizes :address, with: -> { _1.downcase }

  validates :address, presence: true, uniqueness: true
  validates :reason, presence: true

  def self.registered?(email)
    where(address: email).any?
  end

  def self.log_now(email, reason)
    ban = find_or_initialize_by(address: email)
    return true if ban.persisted?

    ban.reason = reason
    ban.save!
  end

  def self.log_later(email, reason)
    Ban::LogJob.perform_later(email, reason)
  end
end
