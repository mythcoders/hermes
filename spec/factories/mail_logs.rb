FactoryBot.define do
  factory :mail_log do
    to { Faker::Internet.email }
    subject { Faker::Cannabis.buzzword }
    was_rerouted { false }
  end
end
