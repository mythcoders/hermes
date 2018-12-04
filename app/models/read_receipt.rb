class ReadReceipt < ApplicationRecord
  belongs_to :mail_log
  has_many :read_receipts_queries
end
