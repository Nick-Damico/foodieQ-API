require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:valid_user)
  end

  it 'is valid with a valid email, password, admin attributes' do
    expect(@user).to be_valid
  end
  it "is invalid without an email"
  it "is invalid without a last name"
  it "is invalid without an email address"
  it "is invalid with a duplicate email address"
end
