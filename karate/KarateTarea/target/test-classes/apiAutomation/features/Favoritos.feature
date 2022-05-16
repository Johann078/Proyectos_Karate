Feature: favoritos

    Background: Precondiciones
        * url apiUrl
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def token = tokenResponse.authToken


    Scenario: Mirar favorito de pagina
        * def timevalidator = read ('classpath:helpers/time-validator.js')

        Given path 'articles'
        Given params  {limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200

        * def slug = response.articles[0].slug
        * def initialCount = 0


        Given path  'articles/'+slug+'/favorite'
        Given header Authorization = 'Token ' + token
        When method Post
        Then status 200
        #  * print response
        And match response ==
            """
            {
            "article": {
            "id": "#number",
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#? timevalidator(_)",
            "updatedAt": "#? timevalidator(_)",
            "authorId": "#number",
            "tagList": [],
            "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string"
            },
            "comments": [],
            "favoritedBy": [
            {
            "id": "#number",
            "email": "#string",
            "username": "#string",
            "password": "#string",
            "image": "#string",
            "bio": "##string",
            "demo": "#boolean"
            }
            ],
            "favorited": "#boolean",
            "favoritesCount": 1
            }
            }
            }

            """


        Given path 'articles'
        Given params  {limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        Then match response.articles[0].favoritesCount ==   + 1


        Given path 'articles'
        Given params  {favorited:"johantest2",limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        And match response ==
            """
            {
                "articles": [
                    {
                        "slug": "#string",
                        "title": "#string",
                        "description": "#string",
                        "body": "#string",
                        "createdAt": "#? timevalidator(_)",
                        "updatedAt": "#? timevalidator(_)",
                        "tagList": [],
                        "author": {
                            "username": "#string",
                            "bio": "##string",
                            "image": "#string"
                        },
                        "comments": [],
                        "favoritesCount": "#number",
                        "favorited": "#boolean"
                    }
                ],
                "articlesCount": "#number"
            }
            """
And match response.articles[0].slug == slug

Given path  'articles/'+slug+'/favorite'
Given header Authorization = 'Token ' + token
When method Delete
Then status 200
* print response.article.favoritesCount
Then match response.article.favoritesCount == 0