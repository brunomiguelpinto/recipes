# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeSearchService do
  let(:author1) { create(:author) }
  let(:author2) { create(:author) }

  let(:category1) { create(:category) }
  let(:category2) { create(:category) }

  let(:cuisine1) { create(:cuisine, name: 'Italian') }
  let(:cuisine2) { create(:cuisine, name: 'Mexican') }

  let!(:base_recipe1) do
    create(:recipe,
           author: author1, category: category1,
           ratings: 5, ingredients: 'milk, chocolate',
           cuisine: cuisine1)
  end
  let!(:base_recipe2) do
    create(:recipe,
           author: author2, category: category2,
           ratings: 4, ingredients: 'milk, eggs',
           cuisine: cuisine2)
  end

  describe '#call' do
    subject(:service_call) { described_class.call(params) }

    context 'when searching by author' do
      let(:params) { { author_id: author1.id } }

      it 'returns recipes authored by the specified author' do
        expect(service_call).to contain_exactly(base_recipe1)
      end
    end

    context 'when searching by category' do
      let(:params) { { category_id: category1.id } }

      it 'returns recipes from the specified category' do
        expect(service_call).to contain_exactly(base_recipe1)
      end
    end

    context 'when searching by ingredients' do
      let(:params) { { ingredients: 'chocolate' } }

      it 'returns recipes containing the specified ingredient' do
        expect(service_call).to contain_exactly(base_recipe1)
      end
    end

    context 'when searching by cuisine' do
      let(:params) { { cuisine_id: cuisine1.id } }

      it 'returns recipes from the specified cuisine' do
        expect(service_call).to contain_exactly(base_recipe1)
      end
    end

    context 'when sorting' do
      let(:params) { { sort_field: 'ratings', sort_direction: 'desc' } }

      it 'returns recipes in the specified order' do
        expect(service_call).to eq([base_recipe1, base_recipe2])
      end
    end

    context 'when paginating' do
      context 'first page' do
        let(:params) { { page: 1, per_page: 1 } }

        it 'returns the first recipe' do
          expect(service_call).to contain_exactly(base_recipe1)
        end
      end

      context 'second page' do
        let(:params) { { page: 2, per_page: 1 } }

        it 'returns the second recipe' do
          expect(service_call).to contain_exactly(base_recipe2)
        end
      end
    end

    context 'with invalid parameters' do
      let(:params) { { sort_field: 'invalid_field', sort_direction: 'desc' } }

      it 'returns recipes ignoring the invalid field' do
        expect(service_call).to match_array([base_recipe1, base_recipe2])
      end
    end
  end
end
