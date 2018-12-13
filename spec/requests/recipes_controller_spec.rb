require "rails_helper"

RSpec.describe "RecipesController", :type => :request do
  before do
    DatabaseCleaner.clean
    @user = create(:valid_user)
    @recipe = build(:recipe)
    @recipe_2 = build(:recipe_2)
    @user.recipes.push(@recipe, @recipe_2)
    @user.save
  end
  describe 'GET /recipes' do

    it 'returns a HTTP status' do
      get api_v1_recipes_url

      expect(response).to have_http_status(200)
    end

    it 'returns a list of recipes' do
      get api_v1_recipes_url

      expect(JSON.parse(response.body)["data"].size).to eq(2)
    end

    it 'will retrieve records' do
      get api_v1_recipes_url

      expect(JSON.parse(response.body)["data"].first["id"]).to eq("1")
      expect(JSON.parse(response.body)["data"].first["attributes"]["title"]).to eq("Quick and easy pad thai")
    end
  end

  describe 'GET /recipes/:id' do
    it 'returns an HTTP status of 200, on success' do
      get api_v1_recipe_url(@recipe)

      expect(response).to have_http_status(200)
    end

    it 'returns an HTTP status of 404, on failure' do
      get api_v1_recipe_url(10)

      expect(response).to have_http_status(404)
    end
  end
end
