# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) { create(:state, symbol: 'CA') }
    let!(:counties) do
      [
        create(:county, name: 'Alameda', state: state),
        create(:county, name: 'Orange', state: state)
      ]
    end

    before do
      get :counties, params: { state_symbol: 'CA' }, format: :json
    end

    it 'returns the JSON representation of the state\'s counties' do
      # 确保预期响应匹配实际响应的格式
      expected_response = counties.as_json(only: %i[id name state_id fips_code fips_class created_at
                                                    updated_at])
      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
