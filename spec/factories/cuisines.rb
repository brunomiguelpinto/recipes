# frozen_string_literal: true

# spec/factories/cuisines.rb

FactoryBot.define do
  factory :cuisine do
    name { "Cuisine - #{Faker::Food.dish}" }
  end
end
