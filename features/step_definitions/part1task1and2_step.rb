# frozen_string_literal: true

Given('task 1.23 I am on the login page') do
  visit '/login'
end

Given('task 1.23 I am on the create article page') do
  visit '/representatives/3/news_items'
end

When('task 1.23 I click {string}') do |button|
  click_button(button)
end

When('task 1.23 I click link {string}') do |button|
  click_link(button)
end

Given('task 1.23 I am on the profile page') do
  visit '/user/profile'
end

Then('task 1.23 I should be signed {word}') do |status|
  visit status == 'in' ? '/user/profile' : '/login'
  expect(page).to have_content(status == 'in' ? 'Logout' : 'Sign In')
end
