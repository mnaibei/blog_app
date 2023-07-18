FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # Add other attributes as needed
  end
end
