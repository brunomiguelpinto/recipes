# spec/models/author_spec.rb
require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    subject { build(:author) }  # assumes you have a FactoryBot definition for :author

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:recipes).dependent(:nullify) }
  end

  describe 'behavior' do
    let!(:author) { create(:author) }
    let!(:recipe) { create(:recipe, author: author) }  # assumes you have a FactoryBot definition for :recipe

    context 'when author is destroyed' do
      it 'nullifies the author_id on its recipes' do
        author.destroy
        expect(recipe.reload.author_id).to be_nil
      end
    end
  end
end
