Feature: task 1.3 make map functional

@load-seed-data @US49
Scenario: click on a county and see list of representatives
  Given Task 1.3: I am on the CA state page task 1.3
  When Task 1.3: I click the button Counties in California
  Then Task 1.3: I should see "Alameda County"
  When Task 1.3: I click the button view Alameda County
  Then Task 1.3: I should be on Alameda Representatives page
  Then Task 1.3: I should see "Table of Representatives"
  And Task 1.3: I should see "Alameda County"
  And Task 1.3: I should see "Henry C. Levy"
  And Task 1.3: I should not see "Contra Costa County"
  Given Task 1.3: I am on the NY state page