class Message < ApplicationRecord
  include WithUuid

  encrypts :html_body
  encrypts :text_body

  def halted?
    halted_at.present?
  end
end
