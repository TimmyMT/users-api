# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InspectTokensJob do
  let!(:users) { create_list(:user, 7) }
  before do
    users.each { |user| TokensCreator.new(user).call }
    users.last(4).each do |user|
      AccessToken.find_by(user_id: user.id).update(expires_in: DateTime.now - 1.hour)
    end
  end

  it '4 last tokens must be expired' do
    subject.perform_now
    expect(AccessToken.where(expired: false).count).to eq 3
  end
end