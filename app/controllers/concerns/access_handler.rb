# frozen_string_literal: true

module AccessHandler
  extend ActiveSupport::Concern
  include TokensCoder

  def access_authorize
    return render_unauthorized unless token_exist?

    receive_token
  end

  def can_write?(user)
    return false if @decoded_token.nil?
    return true if @decoded_token.first[:admin] == true
    return true if user.id == @decoded_token.first["id"]

    false
  end

  def can_delete?(user)
    return false if @decoded_token.nil?
    return true if @decoded_token.first[:admin] == true

    false
  end

  def render_unauthorized
    render json: { error: 'Access denied' }, status: :unauthorized
  end

  private

  def token_exist?
    return false if request.env["HTTP_AUTHORIZATION"].nil?
    return false unless request.env["HTTP_AUTHORIZATION"].include?('Bearer')
    return false if request.env["HTTP_AUTHORIZATION"] == ('Bearer' || 'Bearer ')

    true
  end

  def receive_token
    input = request.env["HTTP_AUTHORIZATION"]
    @token = input.split(' ').last
    finded_token = AccessToken.find_by(token: @token)

    if finded_token&.expires_in > DateTime.now
      receive_decoded_token
    end
  end

  def receive_decoded_token
    return if @token.nil?

    @decoded_token = decode(@token)
  end
end
