require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '#fetch_additional_info_from_civic_api' do
    it 'fetches additional information from Civic API and updates the model' do
      # Stub the API call to Civic API
      allow_any_instance_of(Representative).to receive(:fetch_additional_info_from_civic_api).and_return(nil)

      # Create a representative instance
      representative = create(:representative)

      # Mock the Civic API response (replace with your actual API response structure)
      api_response = {
        'normalizedInput' => { 'line1' => '456 Oak St', 'city' => 'Newtown', 'state' => 'NY', 'zip' => '54321' }
      }

      # Stub the HTTP response with the mock API response
      allow(Net::HTTP).to receive(:get_response).and_return(double(code: '200', body: api_response.to_json))

      # Call the method to fetch additional info
      representative.fetch_additional_info_from_civic_api(double(party: 'Independent'))

      # Reload the model to get the updated information from the database
      representative.reload

      # Assertions
      expect(representative.contact_address).to eq('456 Oak St')
      expect(representative.city).to eq('Newtown')
      expect(representative.state).to eq('NY')
      expect(representative.zip).to eq('54321')
      expect(representative.political_party).to eq('Independent')
    end
  end
end