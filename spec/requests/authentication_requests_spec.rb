require 'rails_helper'

RSpec.describe 'AuthenticationRequests', type: :request do
  before do
    DatabaseCleaner.clean
  end
  describe 'sign up' do
    it 'creates a new User' do
      expect do
        signup_request
      end.to change(User, :count).by(1)
    end

    it 'returns a JWT token on succesful sign up' do
      signup_request

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

  describe 'log out' do
    before do
      @user = create(:user_1)
      @token = login_user(@user)['token']
    end

    it 'it logs out a User successfully' do
      logout_request(@token)

      expect(response).to be_successful
      expect(parse_response['message']).to eq('You have successfully logged out.')
    end
  end

  describe 'Google Auth' do
    it 'logs a Google User in' do
      expect{
        post api_v1_auth_google_path,
          :params => {user: {email: 'tim@gmail.com'}}
      }.to change(User, :count).by(1)
    end
  end
end
