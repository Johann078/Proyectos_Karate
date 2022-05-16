Feature: Sign in user

Background: preconditios
    Given url apiUrl


Scenario: user sign in
    Given path 'users/login'
    And request 
    """
        {
            "user": {
              "email": "#(userEmail)",
              "password": "#(userPassword)"
            }
          }
    """
    When method Post
    Then status 200