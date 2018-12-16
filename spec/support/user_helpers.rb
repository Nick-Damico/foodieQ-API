module UserHelpers
  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  def response_to_json
    json = JSON.parse(response.body)
    json["data"]
  end

  def user_attributes
    response_to_json()["attributes"]    
  end
end
