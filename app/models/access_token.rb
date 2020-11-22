class AccessToken < ApplicationRecord
  belongs_to :user

  validates :token, :expires_in, :user_id, presence: true
end
