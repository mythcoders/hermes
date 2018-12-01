class MailLog < ApplicationRecord
  belongs_to :client

  validates_presence_of :to, :subject
end
