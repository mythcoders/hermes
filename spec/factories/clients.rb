# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Movies::LordOfTheRings.location }
    owner { Faker::Movies::LordOfTheRings.character }
    reroute_email { Faker::Internet.email }
    api_secret { SecureRandom.urlsafe_base64(64) }
    api_key { SecureRandom.urlsafe_base64(64) }
    is_active { true }
    are_emails_sent { false }

    trait :inactive do
      is_active { false }
    end

    trait :allowed_to_send do
      are_emails_sent { true }
    end
  end
end
