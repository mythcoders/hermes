# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  content_type :string
#  environment  :string
#  html_body    :string
#  priority     :string
#  sender       :string
#  sent_at      :datetime
#  subject      :string           not null
#  text_body    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  client_id    :integer          not null
#  tracking_id  :string
#
# Indexes
#
#  index_messages_on_client_id  (client_id)
#
# Foreign Keys
#
#  client_id  (client_id => clients.id)
#
class Message < ApplicationRecord
end
