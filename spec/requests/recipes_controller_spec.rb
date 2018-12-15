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
          token = login_user(@user)["token"]
          post api_v1_recipes_url, :params => {recipe: { title: 'Mushroom Chicken',
            description: 'Best Mushroom chicken out there'} },
            headers: {"HTTP_AUTHORIZATION" => "Bearer #{token}"}
         }.to change(Recipe,:count).by(1)
       expect(response.status).to eq(201)
      end

      it 'creates a user associated recipe' do
        expect{
          post api_v1_user_recipes_url(@user), :params => {recipe: {title: 'Mushroom chicken',
                                                           description: 'Best mushroom chicken'}}
        }.to change(@user.recipes, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'returns errors and 400 status' do
        expect{
          post api_v1_recipes_url, :params => {recipe: {name: 'Mushroom Chicken'}}
        }.to_not change(Recipe, :count)
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'Patch :update' do
    context 'with valid attributes' do
      it 'updates a recipe with modified valid attributes' do
        put api_v1_recipe_path(@recipe), :params => {recipe: {title: 'Djion mushroom chicken'}}
        json_response_title = JSON.parse(response.body)["data"]["attributes"]["title"]
        response_code = response.status

        expect(response_code).to eq(200)
        expect(json_response_title).to eq("Djion mushroom chicken")
      end

      it 'updates associated ingredients with nested params' do
        put api_v1_recipe_path(@recipe), :params => {recipe: {ingredients_attributes: {name: '10 oz mushrooms'}}}

        expect(response.status).to eq(200)
      end
    end

    context 'with invalid attributes' do
      it 'does not update' do
        put api_v1_recipe_path(@recipe), :params => {recipe: {title: ''}}

        expect(response.status).to eq(400)
      end
    end

    context 'associated User belongs to' do
      it 'updates recipe if the associated user is correct' do
        put api_v1_user_recipe_path(@user, @recipe), :params => {recipe: {title: 'Best pad thai'}}

        expect(response.status).to eq(200)
      end

      it 'does not update recipe if the associated user is incorrect' do
        user_2 = create(:user_2)
        put api_v1_user_recipe_path(user_2, @recipe), :params => {recipe: {title: 'Best pad thai'}}

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'Delete :destroy' do
    context 'with authorized User' do
      it 'deletes a record' do
        expect{
          delete api_v1_user_recipe_path(@user,@recipe)
        }.to change(Recipe, :count).by(-1)

        expect(response.status).to eq(204)
      end
    end

    context 'with unauthorized User' do
      it 'does not delete a record' do
        user_2 = create(:user_2)
        expect{
          delete api_v1_user_recipe_path(user_2,@recipe)
        }.to_not change(Recipe, :count)

        expect(response.status).to eq(400)
      end
    end
  end
end
