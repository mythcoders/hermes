class Delivery < ApplicationRecord
  include Actionable

  nillify_blanks :smtp_response, :reporting_mta
end
