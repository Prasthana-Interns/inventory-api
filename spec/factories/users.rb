FactoryBot.define do

  factory :application do
    token = Rails.application.secrets.secret_key_base.to_s
  end

  factory :user do
    name { "shiva kummar" }
    email { Faker::Internet.unique.email }
    phone_number { 9876543210 }
    designation { "Developer" }
    approved { true } 
  end

  factory :user_roles do
    user_id { 2 }
    role_type { 'Admin' }
  end

end