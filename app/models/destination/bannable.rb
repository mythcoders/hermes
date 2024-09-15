module Destination::Bannable
  extend ActiveSupport::Concern

  included do
    has_one :ban, foreign_key: :address, primary_key: :address

    validate :address_isnt_banned, on: :create
  end

  def ban_now(reason)
    Ban.log_now address, reason
  end

  def ban_later(reason)
    ban_now(reason)
  end

  def banned?
    ban.present?
  end

  private

  def address_isnt_banned
    return unless address.present? && banned?

    errors.add(:address, :blacklisted)
  end
end
