class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable

  validate :email_domain_is_mythcoders

  def email_domain
    email.split('@')[1]
  end

  private

  def email_domain_is_mythcoders
    errors.add(:email, 'Invalid domain') if email_domain != 'mythcoders.com'
  end
end
