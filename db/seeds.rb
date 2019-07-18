# frozen_string_literal: true

unless User.where(email: Rails.application.credentials[:support][:key]).any?
  User.create!(name: 'Justin Adkins',
               email: Rails.application.credentials[:support][:key],
               password: Rails.application.credentials[:support][:secret],
               confirmed_at: DateTime.now)
end

Client.create(name: 'Demo Application',
              owner: 'Justin Adkins',
              reroute_email: 'justin.adkins@mythcoders.com',
              is_active: true,
              are_emails_sent: false,
              api_key: 'speak',
              api_secret: 'friend')
