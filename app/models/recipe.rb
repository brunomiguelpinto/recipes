# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :category, optional: true
  belongs_to :cuisine, optional: true

  validates :ingredients, :title, presence: true

  scope :with_ingredient_count, lambda {
    select('recipes.*, jsonb_array_length(ingredients) as ingredient_count')
  }

  scope :order_by_ingredient_count, lambda {
    with_ingredient_count.order('ingredient_count ASC')
  }
end
