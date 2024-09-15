class Bounce < ApplicationRecord
  include Actionable

  nillify_blanks :category, :sub_category, :feedback_id, :reporting_mta, :status, :action, :diagnostic_code
end
