# frozen_string_literal: true

# spec/controllers/events_controller_spec.rb
require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:state) { create(:state, symbol: 'NY') }
  let(:county) { create(:county, state: state, fips_code: '047') }
  let(:events) { create_list(:event, 3, county: county) }

  describe 'GET #index' do
    context 'without filters' do
      before { get :index }

      it 'assigns all events to @events' do
        expect(assigns(:events)).to match_array(Event.all)
      end
    end

    context 'when filtered by state' do
      before { get :index, params: { filter_by: 'state-only', state: 'NY' } }

      it 'assigns filtered events to @events' do
        expect(assigns(:events)).to match_array(events)
      end
    end

    context 'when filtered by county' do
      before { get :index, params: { filter_by: 'state-county', state: 'NY', county: '047' } }

      it 'assigns filtered events to @events' do
        expect(assigns(:events)).to match_array(events)
      end
    end
  end

  describe 'GET #show' do
    context 'when the event exists' do
      before { get :show, params: { id: events.first.id } }

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'assigns the requested event to @event' do
        expect(assigns(:event)).to eq(events.first)
      end
    end
  end
end
