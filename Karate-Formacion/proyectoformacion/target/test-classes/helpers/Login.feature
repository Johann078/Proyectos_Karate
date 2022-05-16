Feature: login

    Background: Define URL
        * url apiUrl

    Scenario: Login
        Given path 'users/login'
        When request
            """
            {
                "user": {
                    "email": "jarv078@gmail.com",
                    "password": "123qwe"
                }
            }
            """
        And method Post
        Then status 200
        * def authToken = response.user.token