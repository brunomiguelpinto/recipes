# frozen_string_literal: true

# app/services/recipe_search_service.rb

# The RecipeSearchService class provides a service for searching recipes
# based on various criteria like author, category, cuisine, and ingredients.
# It also provides the ability to sort and paginate the results.
class RecipeSearchService
  # Valid fields that the user can sort by.
  VALID_SORT_FIELDS = %w[ratings prep_time cook_time].freeze
  # Valid directions for sorting (ascending or descending).
  VALID_SORT_DIRECTIONS = %w[asc desc].freeze
  # Default page number in case none is specified.
  DEFAULT_PAGE = 1
  # Default number of recipes per page in case none is specified.
  DEFAULT_PER_PAGE = 10

  # Class method to initiate the search.
  # @param params [Hash] The search and pagination parameters.
  # @return [ActiveRecord::Relation] The searched and paginated recipes.
  def self.call(params)
    new(params).search
  end

  # Initialize the service with provided parameters.
  # @param params [Hash] The search and pagination parameters.
  def initialize(params)
    @params = params
    @recipes = Recipe.includes(:author, :category, :cuisine).all
  end

  # Execute the search based on the parameters.
  # @return [ActiveRecord::Relation] The searched and paginated recipes.
  def search
    filter_by_author
    filter_by_category
    filter_by_cuisine
    filter_by_ingredients
    apply_sorting
    paginate
  end

  private

  # Filter recipes by author.
  def filter_by_author
    @recipes = @recipes.where(author_id: @params[:author_id]) if @params[:author_id].present?
  end

  # Filter recipes by category.
  def filter_by_category
    @recipes = @recipes.where(category_id: @params[:category_id]) if @params[:category_id].present?
  end

  # Filter recipes by cuisine.
  def filter_by_cuisine
    @recipes = @recipes.where(cuisine_id: @params[:cuisine_id]) if @params[:cuisine_id].present?
  end

  # Filter recipes by ingredients using PostgreSQL's full-text search.
  def filter_by_ingredients
    return unless @params[:ingredients].present?

    query = 'ingredients_tsvector @@ websearch_to_tsquery(?)'
    @recipes = @recipes.where(query, @params[:ingredients])
    @recipes = @recipes.order_by_ingredient_count if sort_by_ingredient_amount?
  end

  def sort_by_ingredient_amount?
    @params[:sort_ingredient_amount].nil? || @params[:sort_ingredient_amount] == 'true'
  end

  # Apply sorting to the recipes if valid sort_field and sort_direction are provided.
  def apply_sorting
    return unless valid_sort_field?(@params[:sort_field])

    direction = valid_sort_direction?(@params[:sort_direction]) ? @params[:sort_direction] : 'desc'
    @recipes = @recipes.order(@params[:sort_field] => direction)
  end

  # Paginate the recipes based on page and per_page parameters.
  def paginate
    page = @params[:page] || DEFAULT_PAGE
    per_page = @params[:per_page] || DEFAULT_PER_PAGE
    @recipes.page(page).per(per_page)
  end

  # Check if the provided sort field is valid.
  # @return [Boolean] True if valid, false otherwise.
  def valid_sort_field?(field)
    VALID_SORT_FIELDS.include?(field)
  end

  # Check if the provided sort direction is valid.
  # @return [Boolean] True if valid, false otherwise.
  def valid_sort_direction?(direction)
    VALID_SORT_DIRECTIONS.include?(direction)
  end
end
