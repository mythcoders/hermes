class Delay < ApplicationRecord
  include Actionable

  nillify_blanks :category, :diagnostic_code, :status, :expiration_time
end
