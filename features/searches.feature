Feature: Manage searches
  In order to keep track of searches
  As a user
  I want to manage the searches

  Scenario: A user sees the searches index
    Given a search exists with a text of "Product to search for"
    When I am on the searches_index
    Then I should see "Product to search for"
  
  
  
