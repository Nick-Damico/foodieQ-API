require "rails_helper"

RSpec.describe "RecipesController", :type => :request do
  before do
    DatabaseCleaner.clean
    @user = create(:user_1)
    @recipe = build(:recipe)
    @recipe_2 = build(:recipe_2)
    @user.recipes.push(@recipe, @recipe_2)
    @user.save
  end

  describe 'GET :index' do
    it 'returns a status of 200 of success' do
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
          post api_v1_recipes_url, :params => {recipe: { title: 'Mushroom Chicken',
            :description  => 'Best Mushroom chicken out there'} },
            :headers      => login_user_set_header(@user)
         }.to change(Recipe,:count).by(1)
       expect(response.status).to eq(201)
      end

      it 'creates a user associated recipe' do
        expect{
          post api_v1_user_recipes_url(@user),
            :params       => {recipe: {title: 'Mushroom chicken',
            :description  => 'Best mushroom chicken'}},
            :headers      => login_user_set_header(@user)
        }.to change(@user.recipes, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'returns errors and 400 status' do
        expect{
          post api_v1_recipes_url,
          :params  => {recipe: {name: 'Mushroom Chicken'}},
          :headers => login_user_set_header(@user)
        }.to_not change(Recipe, :count)
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'Patch :update' do
    context 'with valid attributes' do
      it 'updates a recipe with modified valid attributes' do
        put api_v1_recipe_path(@recipe),
          :params  => {recipe: {title: 'Djion mushroom chicken'}},
          :headers => login_user_set_header(@user)
        json_response_title = JSON.parse(response.body)["data"]["attributes"]["title"]
        response_code = response.status

        expect(response_code).to eq(200)
        expect(json_response_title).to eq("Djion mushroom chicken")
      end

      it 'updates associated ingredients with nested params' do
        put api_v1_recipe_path(@recipe),
          :params   => {recipe: {ingredients_attributes: {name: '10 oz mushrooms'}}},
          :headers  => login_user_set_header(@user)

        expect(response.status).to eq(200)
      end
    end

    context 'with invalid attributes' do
      it 'does not update' do
        put api_v1_recipe_path(@recipe),
          :params   => {recipe: {title: ''}},
          :headers  => login_user_set_header(@user)

        expect(response.status).to eq(400)
      end
    end

    context 'associated User belongs to' do
      it 'updates recipe if the associated user is correct' do
        put api_v1_user_recipe_path(@user, @recipe),
          :params   => {recipe: {title: 'Best pad thai'}},
          :headers  => login_user_set_header(@user)

        expect(response.status).to eq(200)
      end

      it 'does not update recipe if the associated user is incorrect' do
        user_2 = create(:user_2)
        put api_v1_user_recipe_path(user_2, @recipe),
          :params   => {recipe: {title: 'Best pad thai'}},
          :headers  => login_user_set_header(@user)

        expect(response.status).to eq(400)
      end
    end

    context 'with valid image file' do
      it 'adds a recipe image' do
        file = fixture_file_upload(Rails.root.join('public', 'images', 'recipes', 'recipe_1.png'), 'image/png')
        expect{
          patch api_v1_user_recipe_path(@user, @recipe),
          :params  => {recipe: {title: 'Djion mushroom chicken', image: file}},
          :headers => login_user_set_header(@user)
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end
  end

  describe 'Delete :destroy' do
    context 'with authorized User' do
      it 'deletes a record' do
        expect{
          delete api_v1_user_recipe_path(@user,@recipe),
          :headers => login_user_set_header(@user)
        }.to change(Recipe, :count).by(-1)

        expect(response.status).to eq(204)
      end
    end

    context 'with unauthorized User' do
      it 'does not delete a record' do
        user_2 = create(:user_2)
        expect{
          delete api_v1_user_recipe_path(user_2,@recipe),
          :headers => login_user_set_header(user_2)
        }.to_not change(Recipe, :count)

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'Pagination with Pagy' do
    before do
      90.times do
        Recipe.create!(title: Faker::Food.dish, description: Faker::Food.description)
      end
    end
    context 'without params' do
      it 'default request returns 20 recipes' do
        get api_v1_recipes_path
        data = response_to_json

        expect(data.size).to eq(20)
      end
    end

    context 'with params page: 2' do
      it 'returns recipes ranging from id 21 thru 40' do
        get api_v1_recipes_path,
            params: {page: 2}

        data = response_to_json
        first_recipe = data[0]
        last_recipe  = data[data.size - 1]

        expect(first_recipe["id"]).to eq('21')
        expect(last_recipe["id"]).to eq('40')
      end
    end
  end
end
