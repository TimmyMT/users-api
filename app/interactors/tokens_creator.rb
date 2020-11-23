class TokensCreator
  attr_reader :user
  attr_accessor :payload

  def initialize(user)
    @user = user
    @payload = {}
    make_payload
  end

  def call
    user.transaction do
      user.access_tokens.destroy_all
      user.access_tokens.create(
        user: user,
        token: encode(payload),
        expires_in: DateTime.now + 30.minutes
      )
    end
  end

  private

  def encode(payload)
    JWT.encode payload, nil, 'HS256'
  end

  def make_payload
    payload[:id] = user.id
    payload[:first_name] = user.first_name
    payload[:email] = user.email
    payload[:admin] = user.admin
    payload[:salt] = generate_verify_code
  end

  def generate_verify_code
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...64).map{ charset.to_a[rand(charset.size)] }.join
  end
end