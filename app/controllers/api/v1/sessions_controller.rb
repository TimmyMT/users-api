# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params_permit[:email])

        if user&.valid_password?(params_permit[:password])
          token = TokensCreator.new(user).call

          render json: token, status: :created
        else
          render json: { error: 'Something went wrong. Please try again' }, status: :unauthorized
        end
      end

      private

      def params_permit
        params.require(:user).permit(:email, :password)
      end
    end
  end
end