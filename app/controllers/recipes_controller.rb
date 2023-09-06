# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :load_filtering_data, only: [:search]
  def search
    return unless params[:commit] # Check if the form has been submitted

    service_params = search_params
    @recipes = RecipeSearchService.call(service_params)
  end

  private

  def load_filtering_data
    @categories = Category.order(:name).pluck(:name, :id)
    @authors = Author.order(:name).pluck(:name, :id)
    @cuisines = Cuisine.order(:name).pluck(:name, :id)
  end

  def search_params
    params.permit(:category_id, :author_id, :cuisine_id,
                  :ingredients, :sort_field, :sort_direction,
                  :page, :per_page, :sort_ingredient_amount)
  end
end
