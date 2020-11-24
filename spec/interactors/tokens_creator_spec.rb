# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokensCreator do
  let!(:user) { create(:user) }
  subject { TokensCreator.new(user) }
  let(:attributes) { %w[id first_name email admin salt] }

  it 'return generated token' do
    decoded_token = JWT.decode subject.call.token, nil, false

    expect(decoded_token.first['email']).to eq user.email
    expect(decoded_token.first.keys).to match_array(attributes)
  end

  it 'tokens quantity adjustment' do
    expect(user.access_tokens.count).to eq 0
    5.times { subject.call }
    expect(user.access_tokens.count).to eq 3
  end
end