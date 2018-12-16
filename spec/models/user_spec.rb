require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    DatabaseCleaner.clean
    @user = create(:user_1)
  end

  it 'is valid with a valid email, password, admin attributes' do
    expect(@user).to be_valid
  end

  it 'is invalid without an email' do
    @user.email = nil

    expect(@user).to be_invalid
  end

  it 'is invalid without a password' do
    @user.password = nil

    expect(@user).to_not be_valid
  end

  it 'is invalid with a duplicate email address' do
    user_1 = User.create(email: 'user@example.com', password: 'validPass')
    user_2 = User.new(email: 'user@example.com', password: 'validPassToo')

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

  it 'is valid with a properly formatted email address' do
    emails = %w[user@example.com foo@Bar.com user_one@oneUser.com best.place@bestplace.com]

    emails.each do |email|
      @user.email = email

      expect(@user).to be_valid
    end
  end

  describe 'has_many recipes' do
    it 'has a recipes collection method :recipes' do
      expect(@user).to respond_to(:recipes)
      expect(@user.recipes).to eq([])
    end

    it 'has recipes collection' do
      @recipe = Recipe.create(title: "Mom's chicken noodle soup",
                              description: "Mom's delicious homemade chicken noodle soup with celery and carrots.")
      @user.recipes << @recipe
      expect(@user.recipes.length).to eq(1)
      expect(@user.recipes).to include(@recipe)
    end
  end
end
