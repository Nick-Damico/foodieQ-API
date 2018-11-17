FactoryBot.define do
  factory :user do

    factory :valid_user, parent: :user do
      email { 'valid@example.com' }
      password { 'validTest' }
      admin { false }
    end  
  end
end
