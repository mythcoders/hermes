# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::LordOfTheRings.location }
    owner { Faker::LordOfTheRings.character }
    reroute_email { Faker::Internet.email }
    api_secret { Hermes::KeyGenerator.new }
    api_key { Hermes::KeyGenerator.new }
    is_active { true }
    is_allowed_to_send { false }

    trait :inactive do
      is_active { false }
    end

    trait :allowed_to_send do
      is_allowed_to_send { true }
    end
  end
end
