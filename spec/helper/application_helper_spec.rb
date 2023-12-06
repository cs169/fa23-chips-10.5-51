# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#state_ids_by_name' do
    before do
      create(:state, name: 'New Mexico', fips_code: 1)
      create(:state, name: 'New York', fips_code: 2)
    end

    it 'returns a hash mapping state names to their IDs' do
      expected_result = { 'New Mexico' => 1, 'New York' => 2 }
      actual_result = described_class.state_ids_by_name
      expect(actual_result).to eq(expected_result)
    end
  end
end
