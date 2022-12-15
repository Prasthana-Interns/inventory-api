FactoryBot.define do
  
  factory :user do
    name { "shiva kummar" }
    email { Faker::Internet.unique.email }
    phone_number { 9876543210 }
    designation { "Developer" }
    approved { true }
  end
end