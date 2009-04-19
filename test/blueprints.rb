require 'faker'

module Faker
  class Lorem
    Words = %w(am is are was when done here get could can have has smart cool I my we they he it she them Ruby on rails merb jruby web2.0 1.9 mashups advent 2008 tools linux apache quoted Gems plugins routes passive aggressive real world code refactor simple testing rspec behavior driven benchmark profile use server client service impressive number generator rake make done)
  end
end

Sham.login { Faker::Internet.user_name }
Sham.name  { Faker::Name.name } 
Sham.email { Faker::Internet.email }
Sham.title    { Faker::Lorem.sentence }
Sham.body     { Faker::Lorem.paragraph }
Sham.basename { |x| "item_#{x}" }

Article.blueprint do
  title { Sham.title }
  body  { Sham.body  }
  created_by { User.make }
  updated_by { created_by }
end

User.blueprint do
  email    { Sham.email }
  login    { Sham.login }
  name     { Sham.name }
  
  password "testpass"
  password_confirmation "testpass"
end