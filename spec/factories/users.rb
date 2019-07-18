FactoryBot.define do
  factory :user do
    email { "sampl@mythcoders.com" }
    password { Faker::Lorem.characters(10) }
    name { Faker::HarryPotter.character }
  end
end
