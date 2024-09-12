class Sender < ApplicationRecord
  has_many :profiles
  has_many :messages
  has_many :destinations, through: :messages

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  enum :state, %w[active inactive].index_by(&:itself), default: :active

  encrypts :key, deterministic: true
  encrypts :secret, deterministic: true
end
