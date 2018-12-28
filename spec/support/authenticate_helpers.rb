module AuthenticateHelpers
  def signup_request
    post api_v1_signup_path,
    :params => { :user => {
      email:                 'user@example.com',
      password:              'test12345',
      password_confirmation: 'test12345'}}
  end

  def logout_request(token)
    delete api_v1_logout_path,
    :headers => set_auth_bearer_token(token)
  end
end
