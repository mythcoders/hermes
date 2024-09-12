class Client < ApplicationRecord
  has_many :environments
  has_many :messages
  has_many :recipients, through: :messages

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  enum :state, %w[active inactive].index_by(&:itself), default: :active

  encrypts :key, deterministic: true
  encrypts :secret, deterministic: true
end
