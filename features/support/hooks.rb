# frozen_string_literal: true

Before('@load-seed-data') do
  load Rails.root.join('db/seeds.rb')
end
