
Feature: Configuration

  Scenario: Configure routes
    Given the test route
    When the test route is called
    Then the responded status code should be 200

  Scenario Outline: Configure validators
    Given the post resources route
    And <valid or invalid> post parameters
    When the post is created
    Then the responded status code should be 200
    And the responded json should <contain or not contain> the key "validation_errors"
    Examples:
      | valid or invalid | contain or not contain |
      | valid            | not contain            |
      | invalid          | contain                |
