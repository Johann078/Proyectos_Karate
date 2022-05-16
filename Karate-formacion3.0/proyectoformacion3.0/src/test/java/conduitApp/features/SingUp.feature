Feature:Sing Up New User

    Background: Define URL
        Given url apiURL
        * def dataGeneretor = Java.type('helpers.DataGenerate')
        * def randomEmail = dataGeneretor.getRamdonEmail()
        * def randomUsername = dataGeneretor.getRamdonUsername()


    Scenario: New User Sing Up

        Given path 'users'
        And request
            """
            {
            "user": {
            "email": #(randomEmail),
            "password": "qweert",
            "username": #(randomUsername),
            }
            }
            """
        When method Post
        Then status 200
        And match response ==
            """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": "##string",
                    "image": "#string",
                    "token": "#string"
                }
            }
            """