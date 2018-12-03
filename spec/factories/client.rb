# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::LordOfTheRings.location }
    owner { Faker::LordOfTheRings.character }
    reroute_email { Faker::Internet.email }
    api_secret { Hermes::KeyGenerator.new }
    api_key { Hermes::KeyGenerator.new }
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
