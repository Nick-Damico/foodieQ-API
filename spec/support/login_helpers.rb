module LoginHelpers
  # Login and sign_up methods return a JSON web token, to be captured
  # and used on subsequent requests that require authentication
  def login_user(user)
    post api_v1_login_path, :params => {user: {email: user.email,
                                              password: user.password}}
    JSON.parse(response.body)
  end

  def set_auth_bearer_token(token)
    {"HTTP_AUTHORIZATION" => "Bearer #{token}"}
  end

  def login_user_set_header(user)
    token = login_user(user)["token"]
    set_auth_bearer_token(token)
  end

  def delete_request
    token = login_user(@user)["token"]
    delete api_v1_user_path(@user),
    :headers => set_auth_bearer_token(token)
  end
end
