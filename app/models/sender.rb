class Sender < ApplicationRecord
  include Authenticatable

  has_many :profiles
  has_many :messages
  has_many :recipients, through: :messages

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  enum :state, %w[active inactive].index_by(&:itself), default: :active
end
