require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET /users" do
    it "response with a http status of sucess" do
      get :index

      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:id" do
    it "responses with status :success" do
      
    end
  end
end
