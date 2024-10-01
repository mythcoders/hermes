class Click < ApplicationRecord
  include Actionable

  nillify_blanks :ip_address, :user_agent, :url
end
