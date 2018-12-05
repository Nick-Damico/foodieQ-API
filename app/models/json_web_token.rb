class JsonWebToken
  def self.encode(payload)
    expiration = 60.minutes.from_now.to_i
    JWT.encode payload.merge(exp: expiration), Rails.application.secrets.secret_key_base
  end

  def decode(token)
    JWT.decode(token, Rails.Rails.application.secrets.secret_key_base).last
  end
end
