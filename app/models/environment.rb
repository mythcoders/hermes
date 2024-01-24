# == Schema Information
#
# Table name: environments
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  regex            :boolean          default(FALSE), not null
#  reoute_address   :string
#  reply_to_address :string
#  status           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  client_id        :integer          not null
#
# Indexes
#
#  index_environments_on_client_id           (client_id)
#  index_environments_on_client_id_and_name  (client_id,name) UNIQUE
#
# Foreign Keys
#
#  client_id  (client_id => clients.id)
#
class Environment < ApplicationRecord
end
