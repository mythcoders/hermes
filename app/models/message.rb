class Message < ApplicationRecord
  include WithUuid

  encrypts :html_body
  encrypts :text_body
end
