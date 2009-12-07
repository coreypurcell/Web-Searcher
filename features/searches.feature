Feature: Manage searches
  In order to keep track of searches
  As a user
  I want to manage the searches

  Scenario: A user sees the searches index
    Given a search exists with a text of "Product to search for"
     When I am on the searches index
     Then I should see "Product to search for"
  
  Scenario: A user adds a new search
    Given I am on the searches index
     When I follow "New search"
     Then I fill in "Text" with "a new search"
      And I press "Submit"
     Then I should see "Search created."
      And I should be on the searches index
      
  Scenario: Update a search
    Given a search exists with a text of "old search"
      And I am on the searches index
     When I follow "old search"
      And I fill in "Text" with "updated an old search"
      And I press "Submit"
     Then I should see "Search updated."
      And I should see "updated an old search"
  
  Scenario: Delete a search
    Given a search exists with a text of "old search"
      And I am on the searches index
     When I follow "old search"
      And I press "Delete"
     Then I should see "Search deleted."
      And I should be on the searches index
      And I should not see "old search"
  
  
