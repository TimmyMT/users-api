module TokensCoder
  def encode(payload)
    JWT.encode payload, nil, 'HS256'
  end

  def decode(token)
    JWT.decode token, nil, false
  end
end