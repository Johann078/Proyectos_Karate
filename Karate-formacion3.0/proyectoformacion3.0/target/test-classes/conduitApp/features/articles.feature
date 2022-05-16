Feature:Articles

    Background: Define URL
        Given url apiURL
        * def tokenResponse = callonce read('classpath:helpers/Login.feature')
        * def token = tokenResponse.authToken
        * def newArticlesbody = read('classpath:helpers/newArticlesRequest.json')
        * def dataGeneretor = Java.type('helpers.DataGenerate')
        * set newArticlesbody.article.title = dataGeneretor.getRandomArticleValues().title
        * set newArticlesbody.article.description = dataGeneretor.getRandomArticleValues().description
        * set newArticlesbody.article.body = dataGeneretor.getRandomArticleValues().body
        
    Scenario: Create New article and Delete
        Given path 'articles'
        And request newArticlesbody
        * header Authorization = 'Token ' + token
        When method Post
        Then status 200
        * def slug = response.article.slug

        # Given path 'articles',slug
        # * header Authorization = 'Token ' + token
        # When method Delete
        # Then status 204