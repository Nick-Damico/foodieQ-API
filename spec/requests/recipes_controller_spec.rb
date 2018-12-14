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
  describe 'GET :index' do

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

  describe 'GET :show' do
    it 'returns an HTTP status of 200, on success' do
      get api_v1_recipe_url(@recipe)

      expect(response).to have_http_status(200)
    end

    it 'returns an HTTP status of 404, on failure' do
      get api_v1_recipe_url(10)

      expect(response).to have_http_status(404)
    end

    it 'retrieves a resource of recipe' do
      get api_v1_recipe_url(@recipe)
      json_response = JSON.parse(response.body)["data"]

      expect(json_response["id"]).to eq("1")
      expect(json_response["attributes"]["title"]).to eq("Quick and easy pad thai")
    end
  end

  describe 'POST :create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect{
          post api_v1_recipes_url, :params => {recipe: {title: 'Mushroom Chicken',
                                               description: 'Best Mushroom chicken out there'}}
         }.to change(Recipe,:count).by(1)
       expect(response.status).to eq(201)
      end

      it 'returns error if invalid attributes' do
        expect{
          post api_v1_recipes_url, :params => {recipe: {name: 'Mushroom Chicken'}}
        }.to_not change(Recipe, :count)
        expect(response.status).to eq(400)
      end

      it 'creates a user associated recipe' do
        expect{
          post api_v1_user_recipes_url(@user), :params => {recipe: {title: 'Mushroom chicken',
                                                           description: 'Best mushroom chicken'}}
        }.to change(@user.recipes, :count).by(1)            
      end
    end
  end
end
