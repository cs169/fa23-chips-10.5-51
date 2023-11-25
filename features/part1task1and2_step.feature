Feature: task 1 and 2

Scenario: Login&out
  Given task 1.23 I am on the login page
  When task 1.23 I click "Sign in with Google"
  Then task 1.23 I should be signed in

  When task 1.23 I am on the profile page
  When task 1.23 I click link "Logout"
  Then task 1.23 I should be signed out

  When task 1.23 I am on the login page
  When task 1.23 I click "Sign in with GitHub"
  Then task 1.23 I should be signed in

  Given Task 1.3: I am on the CA state page task 1.3
  When Task 1.3: I click the button Counties in California
  Then Task 1.3: I should see "Alameda County"
  When Task 1.3: I click the button view Alameda County
  When task 1.23 I am on the create article page
  Then I should see "Add News Article"
