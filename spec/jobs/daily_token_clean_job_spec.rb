# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyTokenCleanJob do
  let!(:users) { create_list(:user, 7) }
  before do
    users.each { |user| TokensCreator.new(user).call }
    users.last(4).each do |user|
      AccessToken.find_by(user_id: user.id).update(expired: true)
    end
  end

  it 'expired tokens must be deleted' do
    expect(AccessToken.where(expired: true).count).to eq 4
    subject.perform_now
    expect(AccessToken.where(expired: true).count).to eq 0
  end
end