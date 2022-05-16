Feature:Login

    Background: Define URL
        Given url apiURL

    Scenario: Login

        Given path 'users/login'
        And request
            """
            {
                "user": {
                    "email": "jarv078@gmail.com",
                    "password": "123qwe"
                }
            }
            """
        When method Post
        Then status 200 
        * def authToken = response.user.token 
