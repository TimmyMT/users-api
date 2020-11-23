# frozen_string_literal: true

require 'rails_helper'

module RequestsHelper
  include Rack::Test::Methods

  def json
    JSON.parse(last_response.body)
  end
end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
end
