# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Black Friday' }
    description { 'products discount' }
    county
    start_time { 1.day.from_now.beginning_of_hour }
    end_time { 2.days.from_now.end_of_hour }
  end
end
