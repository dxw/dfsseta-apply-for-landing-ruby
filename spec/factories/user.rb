FactoryBot.define do
  factory :user do
    email { "jean@dfsseta.gov.uk" }
    encrypted_password { "password" }
  end
end
