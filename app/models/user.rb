class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable

  validate :email_domain_is_mythcoders

  def email_domain
    email.split('@').last
  end

  private

  def email_domain_is_mythcoders
    if email_domain != 'mythcoders.com'.freeze
      Raven.capture_message(
        "Signup for non-mythcoders account",
        level: 'warning'
      )
      errors.add(:email, 'Domain not valid')
    end
  end
end
