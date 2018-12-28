require 'rails_helper'

RSpec.describe "AuthenticationRequests", type: :request do
  describe "sign_up" do
    before do
      DatabaseCleaner.clean
    end
    it "creates a new User" do
      expect {
        signup
      }.to change(User, :count).by(1)
    end

    it "returns a JWT token on succesful sign up" do
      signup

      expect(response.status).to eq(201)
      expect(parse_response["token"]).to be
    end
  end
end
