# spec/factories/cuisines.rb

FactoryBot.define do
  factory :cuisine do
    name { Faker::Food.cuisine }
  end
end
