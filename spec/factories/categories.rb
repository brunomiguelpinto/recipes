# spec/factories/categories.rb

FactoryBot.define do
  factory :category do
    name { "Category - #{Faker::Food.dish}" }
    # other attributes as necessary
  end
end
