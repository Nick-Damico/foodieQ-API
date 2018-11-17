require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    DatabaseCleaner.clean
    @user = create(:valid_user)
  end

  it 'is valid with a valid email, password, admin attributes' do
    expect(@user).to be_valid
  end

  it "is invalid without an email" do
    @user.email = nil

    expect(@user).to be_invalid
  end

  it "is invalid without a password" do
    @user.password = nil

    expect(@user).to_not be_valid
  end

  it "it defaults to an admin value of false" do
    user = User.create({
      email: 'user@example.com',
      password: 'validUser'
      })

    expect(user).to be_valid
    expect(user.admin).to eq(false)
  end

  it "is invalid with a duplicate email address" do
    user_1 = User.create({email: 'user@example.com', password: 'validPass'})
    user_2 = User.new({email: 'user@example.com', password: 'validPassToo'})

    expect(user_2).to_not be_valid
  end

  it "is invalid without a properly formatted email address"   
end
