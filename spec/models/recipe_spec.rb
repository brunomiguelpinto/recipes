# frozen_string_literal: true

# spec/models/recipe_spec.rb

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { should belong_to(:author).optional }
    it { should belong_to(:category).optional }
    it { should belong_to(:cuisine).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:ingredients) }
  end

  describe 'behavior' do
    context 'when created without an author' do
      let(:recipe) { build(:recipe, author: nil) }

      it 'is valid' do
        expect(recipe.valid?).to be true
      end
    end

    context 'when created without a category' do
      let(:recipe) { build(:recipe, category: nil) }

      it 'is valid' do
        expect(recipe.valid?).to be true
      end
    end

    context 'when created without a cuisine' do
      let(:recipe) { build(:recipe, cuisine: nil) }

      it 'is valid' do
        expect(recipe.valid?).to be true
      end
    end
  end
end
