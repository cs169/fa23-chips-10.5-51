# frozen_string_literal: true

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    # before do
    #   @representative = create(:representative) # Make sure you have a factory for representative
    # end

    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: @representative }
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      get :show, params: { id: @representative }
      expect(response).to render_template('show')
    end
  end
end
