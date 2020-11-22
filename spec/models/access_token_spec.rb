require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:expires_in) }
end
