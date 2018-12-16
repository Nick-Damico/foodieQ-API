FactoryBot.define do
  factory :user do
    factory :user_1, parent: :user do
      email { 'valid@example.com' }
      password { 'validTest' }
      password_confirmation { 'validTest'}
    end

    factory :user_2, parent: :user do
      email { 'test_user_2@example.com'}
      password { 'userTwo'}
      password_confirmation { 'userTwo'}
    end
  end
end
