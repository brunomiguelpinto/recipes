# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { "Delicious Recipe #{Faker::Food.dish}" } # Using Faker to generate a unique dish name
    ingredients do
      Array.new(rand(1..3)) { Faker::Food.ingredient } # Generating an array with 1 to 3 random ingredients
    end
    prep_time { rand(10..120) } # Randomly generating prep time between 10 to 120 minutes
    cook_time { rand(10..240) } # Randomly generating cook time between 10 to 240 minutes
    ratings { rand(1..5) }      # Randomly generating ratings between 1 to 5

    association :author
    association :category
    association :cuisine
  end
end
