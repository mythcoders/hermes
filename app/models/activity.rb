class Activity < ApplicationRecord
  belongs_to :actor, class_name: "Recipient", foreign_key: :recipient_id
  delegated_type :action, types: %w[Bounce Click Complaint Delay Delivery Open Rejection], dependent: :destroy
end
