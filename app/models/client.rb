# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  password   :string           not null
#  state      :integer          default(0), not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clients_on_name      (name) UNIQUE
#  index_clients_on_password  (password)
#  index_clients_on_username  (username)
#
class Client < ApplicationRecord
end
