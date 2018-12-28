require 'rails_helper'

RSpec.describe 'AuthenticationRequests', type: :request do
  before do
    DatabaseCleaner.clean
  end
  describe 'sign up' do
    it 'creates a new User' do
      expect do
        signup
      end.to change(User, :count).by(1)
    end

    it 'returns a JWT token on succesful sign up' do
      signup

      expect(response.status).to eq(201)
      expect(parse_response['token']).to be
    end
  end

  describe 'log in' do
    before do
      @user = create(:user_1)
    end

    it 'successfully logs in a User' do
      login_user(@user)

      expect(response.status).to eq(200)
    end

    it 'returns a JWT token' do
      login_user(@user)

      expect(parse_response['token']).to be
    end
  end
end
