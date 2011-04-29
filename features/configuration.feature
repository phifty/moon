
Feature: Configuration

  Scenario: Configure routes
    Given the test route
    When the test route is called
    Then the responded status code should be 200
