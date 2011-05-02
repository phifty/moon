
Feature: Configuration

  Scenario: Configure routes
    Given the show post resource route
    When the show post is called
    Then the responded status code should be 200

  Scenario Outline: Configure validators
    Given the create post resource route
    And <valid or invalid> post parameters
    When the create post is called
    Then the responded status code should be 200
    And the responded json should <contain or not contain> the key "validation_errors"
    Examples:
      | valid or invalid | contain or not contain |
      | valid            | not contain            |
      | invalid          | contain                |

  Scenario: Configure formatters
    Given the show post resource route
    And valid post parameters
    When the show post is called
    Then the responded status code should be 200
    And the responded json should be "{ "post": { "title": "test", "id": null, "timestamp": "now" } }"
