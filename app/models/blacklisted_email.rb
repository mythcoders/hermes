# == Schema Information
#
# Table name: blacklisted_emails
#
#  id         :integer          not null, primary key
#  address    :string           not null
#  reason     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BlacklistedEmail < ApplicationRecord
end
