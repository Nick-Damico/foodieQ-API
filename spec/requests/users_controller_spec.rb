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
      json_response = response_to_json

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
      attributes = user_attributes

      expect(attributes["email"]).to eq(@user.email)
    end
  end

  describe 'POST :create' do
    context 'with valid attributes' do
      it 'adds a new User' do
        expect{
          post api_v1_users_path, :params => valid_user_params
        }.to change(User, :count).by(1)
      end

      it 'responds successfully' do
        post api_v1_users_path, :params => valid_user_params

        expect(response).to be_success
      end
    end
    context 'with invalid attributes' do
      it 'does not add a User' do
        expect {
          post api_v1_users_path, :params => invalid_user_params
        }.to_not change(User, :count)
      end
    end
  end


end
