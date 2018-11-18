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

  it 'is invalid without a properly formatted email address' do
    emails = %w[user@example,com user_at_foo.org user.name@example.
                foo@bar_baz.com foo@bar+baz.com]

    emails.each do |email|
      @user.email = email

      expect(@user).to_not be_valid
    end
  end

  it "is valid with a properly formatted email address" do
    emails = %w[user@example.com foo@Bar.com user_one@oneUser.com best.place@bestplace.com]

    emails.each do |email|
      @user.email = email

      expect(@user).to be_valid
    end
  end
end
