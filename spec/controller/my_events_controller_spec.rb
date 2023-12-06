# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new Event to @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end
end
