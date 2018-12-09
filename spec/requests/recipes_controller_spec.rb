require "rails_helper"

RSpec.describe "RecipesController", :type => :request do
  before do
    DatabaseCleaner.clean
    @recipe = create(:recipe)
    @recipe_2 = create(:recipe_2)
  end
  describe 'GET /recipes' do
    it 'will retrieve records' do
      get '/api/v1/recipes'
      expect(response).to have_http_status(200)
    end

    it 'returns a list of recipes' do
      get '/api/v1/recipes'
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end
end
