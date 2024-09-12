class BlacklistedEmail < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  validates :reason, presence: true
end
