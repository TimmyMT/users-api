module TokensCoder
  def encode(payload)
    JWT.encode payload, nil, 'none'
  end

  def decode(token)
    JWT.decode token, nil, false
  end
end