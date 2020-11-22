class TokensCreator
  include TokensCoder

  attr_reader :user
  attr_accessor :payload

  def initialize(user)
    @user = user
    @payload = {}
    make_payload
  end

  def call
    user.access_tokens.create(
      user: user,
      token: encode(payload),
      expires_in: DateTime.now + 30.minutes
    )
  end

  private

  def make_payload
    payload[:id] = user.id
    payload[:first_name] = user.first_name
    payload[:email] = user.email
  end
end