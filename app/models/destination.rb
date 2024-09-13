class Destination < ApplicationRecord
  include WithUuid

  encrypts :address, deterministic: true
  enum :address_type, %w[to cc bcc].index_by(&:itself), default: :to

  def self.build_from_list(addresses, address_type)
    addresses.map do |address|
      new(address: address, address_type: type)
    end
  end
end
