# == Schema Information
#
# Table name: recipients
#
#  id             :integer          not null, primary key
#  delivered_at   :datetime
#  email_address  :string           not null
#  recipient_type :string
#  send_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  message_id     :integer          not null
#
# Indexes
#
#  index_recipients_on_message_id  (message_id)
#
# Foreign Keys
#
#  message_id  (message_id => messages.id)
#
class Recipient < ApplicationRecord
end
