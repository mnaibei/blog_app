# FactoryBot.define do
#   factory :user do
#     name { Faker::Name.name }
#     # Add other attributes as needed
#   end
# end

# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    bio { 'I am a user' }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'user.png'), 'image/png') }
  end
end
