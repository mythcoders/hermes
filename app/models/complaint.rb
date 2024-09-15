class Complaint < ApplicationRecord
  include Actionable

  nillify_blanks :category, :feedback_id, :user_agent, :arrived_at
end
