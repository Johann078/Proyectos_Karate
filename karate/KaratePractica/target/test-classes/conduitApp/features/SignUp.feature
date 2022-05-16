
Feature: Sign Up New User

    Background: Preconditions

        * def dataGenerator = Java.type('helpers.DataGenerate')
        * def userData = {"email":"karatetest1523@test3.com","username":"karate12345"}
        * def randomEmail = dataGenerator.getRandomEmail();
        * def randomUsername = dataGenerator.getRandomUsername();
        * url apiUrl    

@ignore
    Scenario: New User Sign UP

        Given path 'users'
        And request
            """
            {
            "user": {
            "email": #(randomEmail),
            "password":"karate123asd",
            "username": #(randomUsername)

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
    Scenario Outline: Validar los mensajes de Error
        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username":"<username>"
                }
            }
            """
        When method Post
        Then status 422
        And match response == <errorRepsonse>

        Examples:
            | email                | password    | username          | errorRepsonse                                       |
            | #(randomEmail)       | karate12345 | KarateUser123     | {"errors": {"username":["has already been taken"]}} |
            | KarateUser1@test.com | karate12345 | #(randomUsername) | {"errors": {"email":["has already been taken"]}}    |
            |                      | karate12345 | #(randomUsername) | {"errors": {"email":["can't be blank"]}}            |
            | #(randomEmail)       |             | #(randomUsername) | {"errors": {"password":["can't be blank"]}}         |
            | #(randomEmail)       | karate12345 |                   | {"errors": {"username":["can't be blank"]}}         |

