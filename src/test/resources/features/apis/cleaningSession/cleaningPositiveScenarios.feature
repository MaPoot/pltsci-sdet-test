Feature: Cleaning session API - Positive Scenarios

  Scenario: Positive - Send valid information to API
    Given A room of dimension
      | x | y |
      | 5 | 5 |
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
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 1      |
      | coords  | [1, 3] |

  Scenario: Positive - When not dirty patches are set then the response should be "patches" equal to 0
    Given A room of dimension
      | x | y |
      | 1 | 1 |
    And Set the initial position of the Hover to
      | x | y |
      | 0 | 0 |
    And Set the dirt patches
      | x | y |
    And I set the instructions "N"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 0      |
      | coords  | [0, 0] |

  Scenario: Positive - When send empty initial position the default should be (0, 0)
    Given A room of dimension
      | x | y |
      | 0 | 0 |
    And Set the initial position of the Hover to
      | x | y |
    And Set the dirt patches
      | x | y |
      | 0 | 0 |
    And I set the instructions "N"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 1      |
      | coords  | [0, 0] |

  Scenario: Positive - When send no instructions the hover should still in the initial position
    Given A room of dimension
      | x | y |
      | 2 | 2 |
    And Set the initial position of the Hover to
      | x | y |
      | 0 | 1 |
    And Set the dirt patches
      | x | y |
      | 0 | 0 |
    And I set the instructions ""
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 0      |
      | coords  | [0, 1] |

  Scenario: Positive - When send initial coordinates (null, null) default should be (0, 0)
    Given A room of dimension
      | x | y |
      | 1 | 1 |
    And Set the initial position of the Hover to
      | x    | y    |
      | null | null |
    And Set the dirt patches
      | x | y |
      | 0 | 0 |
    And I set the instructions "N"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 1      |
      | coords  | [0, 0] |

  Scenario Outline: Positive - When dimension is 1 hover should stay in the same position no matter the instructions
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
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 1       |
      | coords  | [ 0, 0] |
    Examples:
      | Instructions    |
      | NNESEESWNWW     |
      | NNNNNNNNNNN     |
      | SSSSSSSSSSSSSS  |
      | WWWWWWWWWWWWWWW |
      | EEEEEEEEEEEEEE  |

  Scenario: When we send no patches API should return 200 code
    Given A room of dimension
      | x | y |
      | 1 | 1 |
    Then Set the initial position of the Hover to
      | x | y |
      | 0 | 0 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 0       |
      | coords  | [ 0, 0] |

  Scenario: When we send no initial position API should return 200 code
    Given A room of dimension
      | x | y |
      | 5 | 5 |
    And Set the dirt patches
      | x | y |
      | 1 | 0 |
      | 2 | 2 |
      | 2 | 3 |
    And I set the instructions "NNESEESWNWW"
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 0       |
      | coords  | [ 1, 3] |

  Scenario: The API should return 1 cleaned patch when initial position is the same as the patch
    Given A room of dimension
      | x | y |
      | 1 | 1 |
    And Set the initial position of the Hover to
      | x | y |
      | 0 | 0 |
    And Set the dirt patches
      | x | y |
      | 0 | 0 |
    And I set the instructions ""
    When Send a POST request to "/cleaning-sessions"
    Then Validate the response code is 200
    Then Validate the response body
      | patches | 1      |
      | coords  | [0, 0] |

  Scenario: Example of Pending Test Case
    Given This is a pending step

  Scenario: This is a broken test case
    Given This is a broken step
