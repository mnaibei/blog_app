FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    # Add other attributes as needed
  end
end
