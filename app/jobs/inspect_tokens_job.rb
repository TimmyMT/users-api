# frozen_string_literal: true

class InspectTokensJob < ApplicationJob
  queue_as :default

  def perform
    AccessToken.where("expires_in < ?", DateTime.now).update_all(expired: true)
  end
end