# frozen_string_literal: true

Given /Part 2: I am on the Alameda County representatives page/ do
  visit '/search/Alameda%20County'
end

When /Part 2: I click the button News Articles for Kamala Harris/ do
  page.find(:css, '#events > tbody > tr:nth-child(2) > td:nth-child(3) > a').click
end

When /Part 2: I click the button Add News Article/ do
  b = 'body > div > div.flex-grow-1 > div > div > div > div > div.clearfix.my-4 > div > a.mx-1.btn.btn-primary'
  page.find(:css, b).click
end

When /Part 2: I select (.*) from the Representatives dropdown/ do |rep|
  select(rep, from: 'news_item[representative_id]')
end

When /Part 2: I select (.*) from the Issues dropdown/ do |issue|
  select(issue, from: 'news_item[issue]')
end

When /Part 2: I choose the third article/ do
  choose('selected_article_index_2')
end
