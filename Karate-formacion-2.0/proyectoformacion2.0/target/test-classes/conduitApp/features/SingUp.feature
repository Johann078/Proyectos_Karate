Feature: Sing Up New User

    Background: Define URL
        Given url apiURL
        * def tokenResponse = callonce read('classpath:helpers/Login.feature')




    Scenario: New User Sing Up

        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "formacion02@test.test",
                    "password": "12345",
                    "username": "testformacion02"
                }
            }
            """
        When method Post
        Then status 200
