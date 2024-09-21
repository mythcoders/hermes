class Activity < ApplicationRecord
  belongs_to :actor, class_name: "Recipient"
  delegated_type :actionable, types: %w[Bounce Click Complaint Delay Delivery Open Rejection], dependent: :destroy
end
