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
     When I follow "Edit" within "li.search"
      And I fill in "Text" with "updated an old search"
      And I fill in "Site Address" with "http://arstechnica.com"
      And I press "Submit"
     Then I should see "Search updated."
      And I should see "updated an old search"
     
  Scenario: Delete a search
    Given a search exists with a text of "old search"
      And I am on the searches index
     When I follow "Edit" within "li.search"
      And I press "Delete"
     Then I should see "Search deleted."
      And I should be on the searches index
      And I should not see "old search"
  
  Scenario: A user sees the search results
    Given a search exists with text: "macbook", site_address: "http://arstechnica.com", id: 1
      And the following results exists
          | text      | href                | search_id |
          | result 1  | http://result1.com  | 1         |
          | result 2  | http://result2.com  | 1         |
      And I am on the searches index
     When I follow "macbook"
     Then I should see "result 1"
      And I should see "result 2"

   Scenario: A user presses refresh to see new results
    Given a search exists with text: "macbook", site_address: "http://arstechnica.com", id: 1, refreshed_at: "09 Jul 2009 13:28"
      And the following results exists
          | text      | href                | search_id | created_at        |
          | result 1  | http://result1.com  | 1         | 09 Jul 2009 13:28 |
          | result 2  | http://result2.com  | 1         | 09 Jul 2009 13:28 |
      And I am on the search page for "macbook"
      When I follow "Refresh"
      Then I should be on the search page for "macbook"
      And I should see "Results refreshed."
      
      
      
      
  
  
