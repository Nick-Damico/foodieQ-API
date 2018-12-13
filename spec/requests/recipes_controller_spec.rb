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
    # subject { get api_v1_recipes_url }
    # it { is_expected.to have_http_status(:ok) }
    it 'will retrieve records' do
      get api_v1_recipes_url

      expect(response).to have_http_status(200)
    end

    it 'returns a list of recipes' do
      get api_v1_recipes_url

      expect(JSON.parse(response.body)["data"].size).to eq(2)
    end

    it 'will retrieve records' do
      get '/api/v1/recipes/1'

      expect(response.body).to eq({
        "data" => {
          "id" => "1"
        }
        })
    end
  end
end
