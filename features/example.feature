Feature: Example

  @mink:selenium2
  Scenario: Visiting the homepage
    Given I am on the homepage
    Then I should see "how it works"
