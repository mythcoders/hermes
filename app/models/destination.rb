class Destination < ApplicationRecord
  encrypts :address, deterministic: true
end
