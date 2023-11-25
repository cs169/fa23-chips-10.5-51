# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  it 'is valid with valid attributes' do
    rep = described_class.new(name: 'John Doe', title: 'Senator', party: 'Independent', address: '123 Capitol Hill')
    expect(rep).to be_valid
  end

  it
end
