# frozen_string_literal: true

class MessageRecipientFactory
  def self.build_from_array(source, type)
    source.each do |email|
      MessageRecipient.new(email: email, recipient_type: type)
    end
  end
end
