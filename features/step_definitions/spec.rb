# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  # Assuming you have validations in your model
  it 'is valid with valid attributes' do
    rep = Representative.new(name: 'John Doe', title: 'Senator', party: 'Independent', address: '123 Capitol Hill')
    expect(rep).to be_valid
  end

  it 'is invalid without a name' do
    rep = Representative.new(title: 'Senator', party: 'Independent', address: '123 Capitol Hill')
    expect(rep).not_to be_valid
  end
end
