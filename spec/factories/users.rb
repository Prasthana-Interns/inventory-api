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
end




  # factory :user_role do
  #   role_type { 'Admin' }
  # end