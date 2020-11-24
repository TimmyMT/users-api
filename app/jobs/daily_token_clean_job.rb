# frozen_string_literal: true

class DailyTokenCleanJob < ApplicationJob
  queue_as :default

  def perform
    AccessToken.where(expired: true).destroy_all
  end
end