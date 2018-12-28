module UserHelpers
  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  def user_attributes
    response_to_json()["attributes"]
  end

  def valid_user_params
    user_params = {
      :user => {
        :email => 'jack@twitter.com',
        :password  => 'jackTweets',
        :password_confirmation => 'jackTweets'
        }
      }
  end

  def invalid_user_params
    # passwords do not match
    invalid_user_params = {
      :user => {
        :email => 'jack@twitter.com',
        :password  => 'jack',
        :password_confirmation => 'jackTweets'
        }
      }
  end

  def delete_request
    token = login_user(@user)["token"]
    delete api_v1_user_path(@user),
    :headers => set_auth_bearer_token(token)
  end

  def unauth_delete_request
    token = login_user(@user)["token"]
    delete api_v1_user_path(@user2),
    :headers => set_auth_bearer_token(token)
  end
end
