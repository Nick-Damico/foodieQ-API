require 'rails_helper'

RSpec.describe "UsersController", :type => :request do
  before do
    DatabaseCleaner.clean
    @user = create(:user_1)
    @user2 = create(:user_2)
    @recipe = build(:recipe)
    @recipe_2 = build(:recipe_2)
    @user.recipes.push(@recipe, @recipe_2)
    @user.save
  end

  describe 'GET :index' do
    it 'responds successfully' do
      get api_v1_users_path

      expect(response).to be_success
    end

    it 'responds with 200 status' do
      get api_v1_users_path

      expect(response).to have_http_status(200)
    end

    it 'returns a list of users' do
      get api_v1_users_path
      json_response = response_to_json(response)

      expect(json_response.size).to eq(2)
    end
  end

  describe 'GET :show' do
    it 'responds successfully' do
      get api_v1_user_path(@user)

      expect(response).to be_success
    end
    
    it 'returns a status of 200' do
      get api_v1_user_path(@user)

      expect(response).to have_http_status(200)
    end

    it 'returns a users info' do
      get api_v1_user_path(@user)
      json_response = response_to_json

      expect(json_response).to
    end
  end
end
