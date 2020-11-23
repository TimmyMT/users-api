# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:users) { create_list(:user, 4) }
  let!(:base_url) { '/api/v1/users' }
  
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
    let!(:update_params) { build(:user_params) }

    subject { patch "#{base_url}/#{user.id}", user: update_params } 

    context 'when guest tries to update user info' do
      before { subject }

      it 'return status unauthorized' do
        expect(last_response.status).to eq 401
      end

      it 'return error message' do
        expect(json['error']).to eq 'Access denied'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { users.first }
    let!(:update_params) { build(:user_params) }

    subject { delete "#{base_url}/#{user.id}" } 

    context 'when guest tries to update user info' do
      before { subject }

      it 'return status unauthorized' do
        expect(last_response.status).to eq 401
      end

      it 'return error message' do
        expect(json['error']).to eq 'Access denied'
      end
    end
  end
end