Feature: Login in page
    Scenario: Login in page

        Given url apiURL
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
        And method Post
        Then status 200
        # And print response.user.token
        * def authToken = response.user.token