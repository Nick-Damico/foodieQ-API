module UserHelpers
  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  def response_to_json(response)    
    JSON.parse(response.body)["data"]
  end
end
