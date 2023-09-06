# frozen_string_literal: true

# spec/factories/authors.rb

FactoryBot.define do
  factory :author do
    name { Faker::Name.unique.name }
    # other attributes as necessary
  end
end
