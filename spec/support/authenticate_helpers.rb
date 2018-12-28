module AuthenticateHelpers
  def signup
    post api_v1_signup_path,
    :params => { :user => {
      email:                 'user@example.com',
      password:              'test12345',
      password_confirmation: 'test12345'}}
  end
end
