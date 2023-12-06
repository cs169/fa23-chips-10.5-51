# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'New York' }
    symbol { 'NY' }
    fips_code { '36' }
    is_territory { false }
    lat_min { 40.5 }
    lat_max { 45.0 }
    long_min { -79.8 }
    long_max { -71.8 }
  end
end
