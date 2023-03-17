Feature: Cleaning session API - Negative Scenarios

  Scenario Outline: For invalid instructions the API should give a 400 response
    Given A room of dimension
      | x | y |
      | 1 | 1 |
    And Set the initial position of the Hover to
      | x | y |
      | 0 | 0 |
    And Set the dirt patches
      | x | y |
      | 0 | 0 |
    And I set the instructions "<Instructions>"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 400
    Examples:
      | Instructions |
      | AAAAAA       |
      | NNEEAAWW     |
      | 11111111     |
      | N2W1E        |
      | EEAAWW       |

  Scenario: WHen initial position is out of range the API should give 400 response
    Given A room of dimension
      | x | y |
      | 5 | 5 |
    And Set the initial position of the Hover to
      | x  | y  |
      | -1 | -1 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 400

  Scenario: When we send a room with negative dimensions the API should give 400 response
    Given A room of dimension
      | x  | y  |
      | -5 | -5 |
    And Set the initial position of the Hover to
      | x | y |
      | 1 | 2 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 400

  Scenario: If patches are out of range the API should return 400 response
    Given A room of dimension
      | x | y |
      | 5 | 5 |
    And Set the initial position of the Hover to
      | x | y |
      | 1 | 2 |
    And Set the dirt patches
      | x  | y  |
      | -1 | -0 |
      | 2  | 2  |
      | 2  | 3  |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 400

  Scenario: When we send more than two dimensional room API should return an error code
    Given A room of dimension
      | x | y | z |
      | 5 | 5 | 5 |
    And Set the initial position of the Hover to
      | x | y |
      | 1 | 2 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 500

  Scenario: When we send more than two dimensional initial position API should return an error code
    Given A room of dimension
      | x | y |
      | 5 | 5 |
    And Set the initial position of the Hover to
      | x | y | z |
      | 1 | 2 | 2 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 500

  Scenario: When we send more than two dimensional dirt patches API should return an error code
    Given A room of dimension
      | x | y |
      | 5 | 5 |
    And Set the initial position of the Hover to
      | x | y |
      | 1 | 2 |
    And Set the dirt patches
      | x | y | z |
      | 1 | 0 | 1 |
      | 2 | 2 | 0 |
      | 2 | 3 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 500

  Scenario: When we send no room dimensions API should return 500 error code
    Given Set the initial position of the Hover to
      | x | y |
      | 1 | 2 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 500
    Then Validate Error Response
      | path    | /v1/cleaning-sessions |
      | status  | 500                   |
      | error   | Internal Server Error |
      | message | null                  |
