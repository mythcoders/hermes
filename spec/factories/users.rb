# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "#{Faker::Lorem.characters(number: 5)}@mythcoders.com" }
    password { Faker::Lorem.characters(number: 10) }
    name { Faker::Movies::HarryPotter.character }
  end
end
