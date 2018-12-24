require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
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

      expect(response).to be_successful
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

      expect(response).to be_successful
    end

    it 'returns a status of 200' do
      get api_v1_user_path(@user)

      expect(response).to have_http_status(200)
    end

    it 'returns a users info' do
      get api_v1_user_path(@user)
      attributes = user_attributes

      expect(attributes['email']).to eq(@user.email)
    end
  end

  describe 'POST :create' do
    context 'with valid attributes' do
      it 'adds a new User' do
        expect do
          post api_v1_users_path, params: valid_user_params
        end.to change(User, :count).by(1)
      end

      it 'responds successfully' do
        post api_v1_users_path, params: valid_user_params

        expect(response).to be_successful
      end
    end
    context 'with invalid attributes' do
      it 'does not add a User' do
        expect do
          post api_v1_users_path, params: invalid_user_params
        end.to_not change(User, :count)
      end
    end
  end

  describe 'PATCH :update' do
    context 'with authorization' do
      it 'responds successfully with 200' do
        token = login_user(@user)['token']
        patch api_v1_user_path(@user),
              headers: set_auth_bearer_token(token),
              params: { user: { email: 'users_one@example.com', password: 'validTest' } }

        expect(response).to have_http_status(200)
        expect(response).to be_successful
      end

      context 'with valid attributes' do
        it 'updates attributes' do
          token = login_user(@user)['token']
          patch api_v1_user_path(@user),
                headers: set_auth_bearer_token(token),
                params: { user: { email: 'users_one@example.com', password: 'validTest' } }

          attributes = user_attributes
          expect(attributes['email']).to eq('users_one@example.com')
        end
      end

      context 'with invalid attributes' do
        it 'does not update attributes' do
          token = login_user(@user)['token']
          patch api_v1_user_path(@user),
                headers: set_auth_bearer_token(token),
                params: { user: { email: 'invalid.com', password: 'validTest' } }
          user = User.find(@user.id)

          expect(user.email).to_not eq('invalid.com')
        end
      end
    end

    context 'without authorization' do
      it 'responds unsuccessfully' do
        token = login_user(@user)['token']
        patch api_v1_user_path(@user),
              params: { user: { email: 'invalid.com', password: 'validTest' } }

        expect(response).to_not be_successful
      end

      it 'does not let a User update another Users attributes' do
        token = login_user(@user2)['token']
        patch api_v1_user_path(@user),
              headers: set_auth_bearer_token(token),
              params: { user: { email: 'user123@example.com', password: 'validTest' } }

        expect(response).to have_http_status(401)
      end
    end
  end
  describe 'DELETE :destroy' do
    context 'with authorization' do
      it 'responds successfully' do
        delete_request
        expect(response).to be_successful
      end

      it 'responds with status 204' do
        delete_request
        expect(response).to have_http_status(204)
      end

      it 'deletes User' do
        expect do
          delete_request
        end.to change(User, :count).by(-1)
      end
    end

    context 'without authorization' do
      it 'is unsuccessful' do
        unauth_delete_request
        expect(response).to_not be_successful
      end

      it 'responds with status 401' do
        unauth_delete_request
        expect(response).to have_http_status(401)
      end

      it 'does not delete User' do
        expect{
          unauth_delete_request
        }.to_not change(User,:count)
      end
    end
  end

  describe 'Pagination with Pagy' do
    before do
      DatabaseCleaner.clean
      99.times do
        password = Faker::Lorem.words(7)
        User.create!(email: Faker::Internet.email,
                     password: password,
                     password_confirmation: password)
      end
    end
    context 'without params, default request' do
      it 'returns 20 Users' do
        get api_v1_users_path
        data = response_to_json

        expect(data.size).to eq(20)
      end

      it "returns a list of Users with id's ranging 1 thru 20" do
        get api_v1_users_path
        data = response_to_json
        first_user = data[0]
        last_user = data[data.size - 1]

        expect(first_user["id"]).to eq("1")
        expect(last_user["id"]).to eq("20")
      end
    end

    context 'with params, page: 2' do
      it 'returns 20 Users' do
        get api_v1_users_path
        data = response_to_json

        expect(data.size).to eq(20)
      end

      it "returns a list of Users with id's ranging 21 thru 40" do
        get api_v1_users_path,
        params: {page: 2}
        data = response_to_json
        first_user = data[0]
        last_user = data[data.size - 1]

        expect(first_user["id"]).to eq("21")
        expect(last_user["id"]).to eq("40")
      end
    end
  end
end
