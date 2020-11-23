FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end

  factory :user_params, class: Hash do
    initialize_with do
      {
        first_name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password(min_length: 8),
      }
    end
  end
end