# app/services/recipe_search_service.rb
class RecipeSearchService
  VALID_SORT_FIELDS = %w[ratings prep_time cook_time].freeze
  VALID_SORT_DIRECTIONS = %w[asc desc].freeze
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def self.call(params)
    new(params).search
  end

  def initialize(params)
    @params = params
    @recipes = Recipe.all
  end

  def search
    filter_by_author
    filter_by_category
    filter_by_cuisine
    filter_by_ingredients
    apply_sorting
    paginate
  end

  private

  def filter_by_author
    @recipes = @recipes.where(author_id: @params[:author_id]) if @params[:author_id].present?
  end

  def filter_by_category
    @recipes = @recipes.where(category_id: @params[:category_id]) if @params[:category_id].present?
  end

  def filter_by_cuisine
    @recipes = @recipes.where(cuisine_id: @params[:cuisine_id]) if @params[:cuisine_id].present?
  end

  def filter_by_ingredients
    if @params[:ingredients].present?
      query = "ingredients_tsvector @@ websearch_to_tsquery(?)"
      @recipes = @recipes.where(query, @params[:ingredients])
    end
  end

  def apply_sorting
    if valid_sort_field?(@params[:sort_field])
      direction = valid_sort_direction?(@params[:sort_direction]) ? @params[:sort_direction] : 'desc'
      @recipes = @recipes.order(@params[:sort_field] => direction)
    end
  end

  def paginate
    page = @params[:page] || DEFAULT_PAGE
    per_page = @params[:per_page] || DEFAULT_PER_PAGE
    @recipes.page(page).per(per_page)
  end

  def valid_sort_field?(field)
    VALID_SORT_FIELDS.include?(field)
  end

  def valid_sort_direction?(direction)
    VALID_SORT_DIRECTIONS.include?(direction)
  end
end
