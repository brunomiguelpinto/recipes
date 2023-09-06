# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RecipeSearchService do
  # Preparation: Create some sample data for testing.
  let!(:author1) { create(:author) }
  let!(:author2) { create(:author) }

  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }

  let!(:recipe1) { create(:recipe, author: author1, category: category1, ratings: 5, ingredients: 'milk, chocolate') }
  let!(:recipe2) { create(:recipe, author: author2, category: category2, ratings: 4, ingredients: 'milk, eggs') }

  describe '#call' do
    context 'when searching by author' do
      it 'returns the correct recipes' do
        results = RecipeSearchService.call(author_id: author1.id)
        expect(results).to contain_exactly(recipe1)
      end
    end

    context 'when searching by category' do
      it 'returns the correct recipes' do
        results = RecipeSearchService.call(category_id: category2.id)
        expect(results).to contain_exactly(recipe2)
      end
    end

    context 'when searching by ingredients' do
      it 'returns the correct recipes' do
        results = RecipeSearchService.call(ingredients: 'chocolate')
        expect(results).to contain_exactly(recipe1)
      end
    end

    context 'when sorting' do
      it 'returns the recipes in the correct order' do
        results = RecipeSearchService.call(sort_field: 'ratings', sort_direction: 'desc')
        expect(results.first).to eq(recipe1)
        expect(results.second).to eq(recipe2)
      end
    end

    context 'when paginating' do
      it 'returns the correct page of results' do
        results = RecipeSearchService.call(page: 1, per_page: 1)
        expect(results).to contain_exactly(recipe1)

        results = RecipeSearchService.call(page: 2, per_page: 1)
        expect(results).to contain_exactly(recipe2)
      end
    end

    context 'with invalid parameters' do
      it 'ignores invalid sort field' do
        results = RecipeSearchService.call(sort_field: 'invalid_field', sort_direction: 'desc')
        expect(results).to match_array([recipe1, recipe2])
      end
    end
  end
end
