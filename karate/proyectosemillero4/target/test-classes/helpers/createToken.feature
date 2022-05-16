Feature: Create Token
Background: precondiciones 
    Given url apiUrl

    Scenario:Create Token
        
        And request
            """
            {
                "user": {
                    "email": "testjohan@test.com",
                    "password": "karate123"
                }
            }
            """
        And path 'users/login'
        When method Post
        Then status 200
        * def authToken = response.user.token
        * print authToken
       