require 'rails_helper'

RSpec.describe "UsersController", :type => :request do
  before do
    DatabaseCleaner.clean
    @user = create(:valid_user)
    @recipe = build(:recipe)
    @recipe_2 = build(:recipe_2)
    @user.recipes.push(@recipe, @recipe_2)
    @user.save
  end

  describe 'GET :index' do
    it 'returns a status of 200 of success' do
      get api_v1_users_path

      expect(response).to have_http_status(200)
    end

    it 'returns a list of users' do
      get api_v1_users_path
      json_response = response_to_json(response)

      expect(json_response.size).to eq(2)
    end
  end
end
