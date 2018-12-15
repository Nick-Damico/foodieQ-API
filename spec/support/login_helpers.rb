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
end
