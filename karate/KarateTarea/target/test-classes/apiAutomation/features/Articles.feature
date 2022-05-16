Feature: favoritos
    Background: preconditions
        * url apiUrl
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def token = tokenResponse.authToken
        * def timevalidator = read ('classpath:helpers/time-validator.js')
    # @ignore
    Scenario: Favorite articles


        # Step 1: Get atricles of the global feed
        Given path 'articles'
        Given params  {limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        * def slug = response.articles[0].slug
        * def initialCount = 0

        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        Given path 'articles'
        Given params  {favorited:"johantest2",limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        * def slug2 = response.articles[0].slug 

        # Step 3: Make POST request to increse favorites count for the first article
        Given path  'articles/'+slug+'/favorite'
        Given header Authorization = 'Token ' + token
        When method Post
        Then status 200
        # Step 4: Verify response schema
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
            "tagList":  "#array",
            "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string"
            },
            "comments": "#array",
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

        # Step 5: Verify that favorites article incremented by 1
        Given path 'articles'
        Given params  {limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
        Then match response.articles[0].favoritesCount == initialCount  + 1

      # Step 6: Get all favorite articles
        Given path 'articles'
        Given params  {favorited:"johantest2",limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
      # Step 7: Verify response schema
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
      # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        And match response.articles[0].slug == slug
      # Step 9: Delete favorite  and favoritesCount
        Given path  'articles/'+slug+'/favorite'
        Given header Authorization = 'Token ' + token
        When method Delete
        Then status 200
        * print response.article.fav    oritesCount
        Then match response.article.favoritesCount == 0

    Scenario: Comment articles
         # Step 1: Get atricles of the global feed

        Given path 'articles'
        Given params  {limit:10,offset:0}
        Given header Authorization = 'Token ' + token
        When method Get
        Then status 200
       # Step 2: Get the slug ID for the first arice, save it to variable
        * def slug = response.articles[0].slug

       # Step 3: Make a GET call to 'comments' end-point to get all comments
      
        Given path  'articles/'+slug+'/comments'
        Given header Authorization = 'Token ' + token
        When method Get
      # Step 4: Verify response schema
        And match response ==
            """
                {
                    "comments": [
                        {
                            "id": "#number",
                            "createdAt": "#? timevalidator(_)",
                            "updatedAt": "#? timevalidator(_)",
                            "body": "#string",
                            "author": {
                                "username": "#string",
                                "bio": "##string",
                                "image": "#string",
                                "following": "#boolean"
                            }
                        },
                        {
                            "id": "#number",
                            "createdAt": "#? timevalidator(_)",
                            "updatedAt": "#? timevalidator(_)",
                            "body": "#string",
                            "author": {
                                "username": "#string",
                                "bio": "##string",
                                "image": "#string",
                                "following": "#boolean"
                            }
                        }
                    ]
                }
            """
        #Step 5: Get the count of the comments array lentgh and save to variable
         * def articlesCount = karate.sizeOf(response.comments)
         * print articlesCount
# Step 6: Make a POST request to publish a new comment
# Given path  'articles/'+slug+'/comments'
# Given header Authorization = 'Token ' + token
# Given request
# """
#     {
#         "comment": {
#           "body": "hola esto es un comentario"
#         }
#       }
# """
# When method Post
# Then status 200
# # Step 7: Verify response schema that should contain posted comment text

# Given path  'articles/'+slug+'/comments'
# Given header Authorization = 'Token ' + token
# When method Get
# And match response
# """
#     {
#         "comments": [
#             {
#                 "id": "#number",
#                 "createdAt": "#? timevalidator(_)",
#                 "updatedAt": "#? timevalidator(_)",
#                 "body": "#string",
#                 "author": {
#                     "username": "#string",
#                     "bio": "##string",
#                     "image": "#tring",
#                     "following": "#boolean"
#                 }
#             }
#         ]
#     }
# """

