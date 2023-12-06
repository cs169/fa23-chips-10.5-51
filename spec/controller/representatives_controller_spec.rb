# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    let!(:representatives) do
      3.times.map do |i|
        Representative.create!(name: "Representative #{i}")
      end
    end

    it 'correctly creates and assigns representatives' do
      get :index
      expect(assigns(:representatives)).to match_array(representatives)
    end
  end
end
