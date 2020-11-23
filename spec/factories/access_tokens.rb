FactoryBot.define do
  factory :token, class: AccessToken do
    association :user_id, factory: :user
    expires_in { DateTime.now + 30.minutes }
  end
end