module ResponseHelpers
  def response_to_json
    json = JSON.parse(response.body)
    json["data"]
  end

  def parse_response
    JSON.parse(response.body)
  end
end
