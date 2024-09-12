class Recipient < ApplicationRecord
  encrypts :email_address, deterministic: true
end
