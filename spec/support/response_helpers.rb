module ResponseHelpers
  def response_to_json
    json = JSON.parse(response.body)
    json["data"]
  end
end
