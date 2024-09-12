class Message < ApplicationRecord
  encrypts :html_body
  encrypts :text_body
end
