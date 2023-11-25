# frozen_string_literal: true

Given /Task 1.3: I am on the (.*) state page/ do |state|
  visit "/state/#{state}"
end

When /Task 1.3: I click the button Counties in California/ do
  page.find(:css, '#actionmap-counties-details-header > h3 > button').click
end

When /Task 1.3: I click the button view Alameda County/ do
  page.find(:css, '#actionmap-state-counties-table > tbody > tr:nth-child(1) > td:nth-child(4) > a').click
end

Then /Task 1.3: I should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /Task 1.3: I should be on Alameda Representatives page$/ do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == '/search/Alameda%20County'
  else
    assert_equal '/search/Alameda%20County', current_path
  end
end

Then /Task 1.3: I should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
