require 'rails_helper'
require 'jwt'

RSpec.describe Api::V1::RecipesController, type: :controller do

context 'when the request with NO authentication header' do
   it 'should return unauth for retrieve current user info before login' do
     get :index
     expect(response).to have_http_status(:unauthorized)
   end
 end

  it 'sends list of recipes' do
    # get '/api/v1/recipes'
    # response = JSON.parse(response.body)
    # binding.pry
    # expect(response).to have_http_status(:unauthorized)
  end
end
