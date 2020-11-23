# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:users) { create_list(:user, 4) }
  let!(:base_url) { '/api/v1/users' }

  describe 'POST #create' do
    let!(:create_params) { build(:user_sign_up_params) }

    context 'guest sign up' do
      before { post base_url, user: create_params }

      it 'return status created' do
        expect(last_response.status).to eq 201
      end

      it 'return created info' do
        expect(json['id']).to eq User.last.id
      end
    end

    let!(:invalid_password_params) { build(:user_params) }

    context 'when inserted invalid data for sign up' do
      before { post base_url, user: invalid_password_params }

      it 'return status bad request' do
        expect(last_response.status).to eq 400
      end

      it 'return error message' do
        expect(json['errors']).to eq ['Invalid passwords']
      end
    end

    context 'when inserted invalid data for sign up' do
      before do
        post base_url, user: { email: 'invalid email', password: '123qweQ!', password_confirmation: '123qweQ!' }
      end

      it 'return status bad request' do
        expect(last_response.status).to eq 400
      end

      it 'return error message' do
        expect(json['errors']).to eq ['Email is invalid', "First name can't be blank"]
      end
    end
  end
  
  describe 'GET #index' do
    context 'guest can get users list' do
      before do
        get base_url
      end

      it 'return response status 200' do
        expect(last_response.status).to eq 200
      end

      it 'return users array' do
        expect(json.pluck('id')).to match_array(users.pluck(:id))
      end
    end
  end

  describe 'GET #show' do
    context 'guest can get user info' do
      before do
        get "#{base_url}/#{users.pluck(:id).first}"
      end

      it 'return response status 200' do
        expect(last_response.status).to eq 200
      end

      it 'return users array' do
        expect(json['id']).to eq users.pluck(:id).first
        expect(json['first_name']).to eq users.first.first_name
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user) { users.first }
    let!(:update_params) { build(:user_update_params) }

    context 'when guest tries to update user info' do
      before do
        patch "#{base_url}/#{user.id}", user: update_params
      end

      it 'return status unauthorized' do
        expect(last_response.status).to eq 401
      end

      it 'return error message' do
        expect(json['error']).to eq 'Access denied'
      end
    end

    context 'when admin tries to update user' do
      let!(:admin) { create(:user, admin: true) }
      let!(:admin_token) { TokensCreator.new(admin).call }

      before do
        patch "#{base_url}/#{user.id}", { user: update_params },
        { "HTTP_AUTHORIZATION" => "Bearer #{admin_token.token}" }
      end

      it 'return status unauthorized' do
        expect(last_response.status).to eq 200
      end

      it 'return updated user info' do
        expect(json['first_name']).to eq 'Updated name'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:admin) { create(:user, admin: true) }
    let!(:user) { create(:user) }
    let!(:update_params) { build(:user_params) }

    context 'when guest tries to delete user' do
      before { delete "#{base_url}/#{user.id}" }

      it 'return status unauthorized' do
        expect(last_response.status).to eq 401
      end

      it 'return error message' do
        expect(json['error']).to eq 'Access denied'
      end
    end

    context 'when admin tries to delete user' do
      let!(:admin_token) { TokensCreator.new(admin).call }

      before do
        delete "#{base_url}/#{user.id}", {}, { "HTTP_AUTHORIZATION" => "Bearer #{admin_token.token}" }
      end

      it 'return status unauthorized' do
        expect(last_response.status).to eq 204
      end
    end
  end
end