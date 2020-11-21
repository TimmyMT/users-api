# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.all.order(created_at: :desc)
  
        render json: @users, status: :ok
      end

      def show
        render json: @user, status: :ok
      end

      def create
        @user = User.new(params_permit)

        if @user.valid?
          @user.save

          render json: @user, status: :created
        else
          errors = []
          @user.errors.full_messages.each { |error| errors << error }

          render json: { errors: errors }, status: :bad_request
        end
      end

      def update
        @user.update(params_permit)

        render json: @user, status: :ok
      end

      def destroy
        @user.destroy

        render json: @user, status: :no_content
      end

      private

      def render_not_found
        render json: { error: 'Record is not exist' }, status: :not_found
      end

      def set_user
        @user = User.find(params[:id])
      end

      def params_permit
        params.require(:user).permit(:email, :password, :first_name)
      end
    end
  end
end
