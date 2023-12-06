# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Bruce' }
    state
    fips_code { '047' }
    fips_class { 'H1' }
  end
end
