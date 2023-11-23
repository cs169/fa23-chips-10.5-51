FactoryBot.define do
  factory :representative do
    name { 'John Doe' }
    ocdid { 'ocd-division/country:us' }
    title { 'Mayor' }
    contact_address { '123 Main St' }
    city { 'Anytown' }
    state { 'CA' }
    zip { '12345' }
    political_party { 'Independent' }
  end
end