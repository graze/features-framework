Feature: Example

  @mink:selenium2
  Scenario: Visiting the homepage
    Given I am on the homepage
    When I follow "snacks"
    Then I should see a list of snacks
