require 'rails_helper'

RSpec.describe User, type: :model do
  before do
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
    user = User.new({
      email: 'valid@example.com',
      password: 'validUser'
      })

    expect(user).to be_valid
    expect(user.admin).to eq(false)
  end

  it "is invalid with a duplicate email address"
end
