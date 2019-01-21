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

  describe 'JWT login' do
    context 'with valid Token' do
      it 'authenticates and logs User in' do
        @user = create(:user_1)
        token = login_user(@user)["token"]
        post api_v1_jwt_login_path, :headers => set_auth_bearer_token(token)

        user_email = parse_response["user"]["email"]
        
        expect(user_email).to eq(@user.email)
        expect(response).to have_http_status(200)
      end
    end
  end
end
