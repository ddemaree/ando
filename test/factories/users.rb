Factory.define :user do |user|
  user.name                  { Faker::Name.name }
  user.sequence(:email)      { |n| "user#{n}@example.com" }
  user.password              { "password" }
  user.password_confirmation { "password" }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.email_confirmed       { true }
end