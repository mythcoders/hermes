class Activity < ApplicationRecord
  belongs_to :destination
  delegated_type :actionable, types: %w[Click Bounce Complaint Delivery Open Rejection Delay]
end
