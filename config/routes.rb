# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end

  root 'main#index'
end
