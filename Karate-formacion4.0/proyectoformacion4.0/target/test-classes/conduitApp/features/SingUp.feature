Feature: Sing up New User

    Background: precondicions
        Given  url apiURL
        * def tokenResponse = callonce read('classpath:helpers/Login.feature')
        * def token = tokenResponse.authToken
    Scenario:New User Sing Up
        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "pepito2.perez2@test2.test2",
                    "password": "12345",
                    "username": "pepito2"
                }
            }
            """
        When method Post
        Then status 200