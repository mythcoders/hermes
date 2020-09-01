# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    client { create(:client) }
    sender { Faker::Internet.email }
    subject { Faker::Cannabis.buzzword }
    environment { 'rspec' }
    tracking_id { SecureRandom.uuid }
  end
end
