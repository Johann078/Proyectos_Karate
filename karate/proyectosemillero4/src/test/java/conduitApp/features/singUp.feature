Feature: Sing Up New User

    Background: precondiciones
        Given url apiUrl
        * def dataGenerator = Java.type('helpers.DataGenerate')
        * def userData = {"email":"testjohansemillero42@test.com","username":"karatesemillero42"}
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

    @ignore
    Scenario: New User Sing UP
        Given  path 'users'
        When request
            """
            {
            "user": {
            "email": #(randomEmail),
            "password": "karate123",
            "username": #(randomUsername)
            }
            }
            """

        And method Post
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

    Scenario Outline: Validate Sing Up Error Message

        Given path 'users'
        When request
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
            """

        And method Post
        Then status 422
        And match response == <errormessage>

        Examples:
            | email                | password  | username          | errormessage                                       |
            | #(randomEmail)       | karate123 | karateUser123     | {"errors":{"username":["has already been taken"]}} |
            | karateUser1@test.com | karate123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
            |                      | karate123 | #(randomUsername) | {"errors":{"email":["can't be blank"]}}            |
            | #(randomEmail)       |           | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |
            | #(randomEmail)       | karate123 |                   | {"errors":{"username":["can't be blank"]}}         |