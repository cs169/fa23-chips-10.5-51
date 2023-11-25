# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  let(:representative) do
    described_class.new(
      name:    'John Doe',
      title:   'Senator',
      party:   'Independent',
      address: '123 Capitol Hill'
    )
  end

  it 'is valid with valid attributes' do
    expect(representative).to be_valid
  end
end
