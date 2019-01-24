# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.create(name: 'Demo Application',
              owner: 'Justin Adkins',
              reroute_email: 'justin.adkins@mythcoders.com',
              is_active: true,
              are_emails_sent: false,
              api_key: 'speak',
              api_secret: 'friend')
