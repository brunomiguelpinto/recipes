# frozen_string_literal: true

# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    subject { build(:category) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:recipes).dependent(:nullify) }
  end

  describe 'behavior' do
    let!(:category) { create(:category) }
    let!(:recipe1) { create(:recipe, category:) }
    let!(:recipe2) { create(:recipe, category:) }

    context 'when category is destroyed' do
      it 'nullifies the category_id on its recipes' do
        category.destroy

        recipe1.reload
        recipe2.reload

        expect(recipe1.category_id).to be_nil
        expect(recipe2.category_id).to be_nil
      end
    end
  end
end
