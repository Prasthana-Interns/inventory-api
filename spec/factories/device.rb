FactoryBot.define do
  factory :device  do
    name { Faker::Name.name }
    device_type { "laptop" }
    os { "windows" }
  end
end