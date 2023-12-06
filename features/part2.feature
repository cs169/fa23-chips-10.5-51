Feature: Iteration 2 News Articles

@load-seed-data @US49
Scenario: add new news article
  Given task 1.23 I am on the login page
  When task 1.23 I click "Sign in with Google"
  Then task 1.23 I should be signed in
  Given Part 2: I am on the Alameda County representatives page
  When Part 2: I click the button News Articles for Kamala Harris
  Then Task 1.3: I should see "Listing News Articles for Kamala D. Harris"
  When Part 2: I click the button Add News Article
  Then Task 1.3: I should see "Edit news article"
  When Part 2: I select Joseph R. Biden from the Representatives dropdown
  When Part 2: I select Free Speech from the Issues dropdown
  When task 1.23 I click "commit"
  Then Task 1.3: I should see "Representative: Joseph R. Biden"
  Then Task 1.3: I should see "Issue: Free Speech"
  Then Task 1.3: I should see "Select an article:"
  When Part 2: I choose the third article
  When task 1.23 I click "commit"
  Then Task 1.3: I should see "Daily Press Briefing by the Office of the Spokesperson for the Secretary-General"
