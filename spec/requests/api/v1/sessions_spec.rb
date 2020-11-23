# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  let!(:base_url) { '/api/v1/sessions' }
  let!(:user) { create(:user, email: 'test@test.com', password: '123qweQ!') }

  context 'when tries to get access token' do
    context 'with valid params' do
      before { post base_url, { user: { email: user.email, password: '123qweQ!' } } }

      it 'return status created' do
        expect(last_response.status).to eq 201
      end

      it 'return token' do
        decoded_token = JWT.decode json['token'], nil, false
        expect(decoded_token.first['email']).to eq user.email
      end
    end
    
    context 'with valid params' do
      before { post base_url, { user: { email: user.email, password: '123qweQ' } } }

      it 'return status unauthorized' do
        expect(last_response.status).to eq 401
      end

      it 'return error message' do
        expect(json['error']).to eq 'Something went wrong. Please try again'
      end
    end
  end
end