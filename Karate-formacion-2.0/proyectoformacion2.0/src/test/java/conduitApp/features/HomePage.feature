Feature: Tests for the Home Page

    Background: Define URL
        Given url apiURL
        * def tokenResponse = callonce read('classpath:helpers/Login.feature')
        * def token = tokenResponse.authToken
        



    Scenario: Get all tags

        Given path 'tags'
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        # * print response
        Then match response.tags contains ['karate','Formacion']
        Then match response.tags !contains 'Oscars'
        Then match response.tags contains any ['Rojo','Azul','Test2']
        Then match response.tags == '#array'
        Then match each response.tags == '#string'

    Scenario: Get articles from the page

        * def timevalidator = read ('classpath:helpers/time-validator.js')

        Given path 'articles'
        Given header Authorization = 'Token ' + token
        And param limit = 10
        And param offset = 0
        When method Get
        Then status 200
        # And match response.articles == '#[5]'
        And match response.articlesCount == 4
        And match response ==
            """
            {"articles":'#[4]',
            "articlesCount": 4
            }
            """
        And match response.articlesCount != 100

        And match response.articles[0].createdAt contains '2022'
        # And match response.articles[*].favoritesCount contains 696
        And match response.articles[*].author.bio contains null
        And match response..bio contains null
        And match response..bio contains '##string'
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'

        And match each response.articles ==
            """
            {
            "slug": '#string',
            "title": '#string',
            "description": '#string',
            "body": '#string',
            "tagList": '#array',
            "createdAt": '#? timevalidator(_)',
            "updatedAt": '#? timevalidator(_)',
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
            "username": '#string',
            "bio": '##string',
            "image": '#string',
            "following": '#boolean'
            }
            }
            """