FactoryBot.define do
  factory :user do

    factory :valid_user, parent: :user do
      email { 'valid@example.com' }
      password { 'validTest' }
      password_confirmation { 'validTest'}
    end
  end
end
