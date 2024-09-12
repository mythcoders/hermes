class Recipient < ApplicationRecord
  encrypts :address, deterministic: true
end
