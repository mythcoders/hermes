module Destination::Bannable
  extend ActiveSupport::Concern

  included do
    has_one :ban, foreign_key: :address, primary_key: :address
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
end
