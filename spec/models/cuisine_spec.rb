# spec/models/cuisine_spec.rb

require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  describe 'validations' do
    subject { build(:cuisine) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:recipes).dependent(:nullify) }
  end

  describe 'behavior' do
    let!(:cuisine) { create(:cuisine) }
    let!(:recipe1) { create(:recipe, cuisine: cuisine) }
    let!(:recipe2) { create(:recipe, cuisine: cuisine) }

    context 'when cuisine is destroyed' do
      it 'nullifies the cuisine_id on its recipes' do
        cuisine.destroy

        recipe1.reload
        recipe2.reload

        expect(recipe1.cuisine_id).to be_nil
        expect(recipe2.cuisine_id).to be_nil
      end
    end
  end
end
