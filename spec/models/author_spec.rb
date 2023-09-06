# frozen_string_literal: true

RSpec.describe Author do
  describe 'validations' do
    subject { create(:author) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
