# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :confirmable,
    :lockable, :timeoutable

  validate :email_domain_is_mythcoders

  def email_domain
    email.split("@").last
  end

  def initials
    name.split.map(&:first).join
  end

  private

  def email_domain_is_mythcoders
    return if email_domain == "mythcoders.com"

    Raven.capture_message("Signup for non-mythcoders account", level: "warning")
    errors.add(:email, "Domain not valid")
  end
end
