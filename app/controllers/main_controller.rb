# frozen_string_literal: true

# MainController
class MainController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index; end
end