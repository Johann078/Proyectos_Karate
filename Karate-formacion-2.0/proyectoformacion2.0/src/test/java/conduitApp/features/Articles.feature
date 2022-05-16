Feature: Articles

    Background: Define URL
        Given url apiURL
        * def tokenResponse = callonce read('classpath:helpers/Login.feature')
        * def token = tokenResponse.authToken
        * def articleBody = read('classpath:helpers/newArticle.json')
        * def dataGenerator = Java.type('helpers.DataGenerate')
        * set articleBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleBody.article.body = dataGenerator.getRandomArticleValues().body




    Scenario: Create New Article and Delete
        Given  header Authorization = 'Token ' + token
        Given path 'articles'
        And request articleBody
        When method Post
        Then status 200
        And match response.article.title == articleBody.article.title
        * def slug = response.article.slug
        * print response

        Given path 'articles'
        Given header Authorization = 'Token ' + token
        And param limit = 10
        And param offset = 0
        When method Get
        Then status 200
        And match response.articles[0].title == articleBody.article.title


        Given  header Authorization = 'Token ' + token
        Given path 'articles',slug
        When method Delete
        Then status 204

        Given path 'articles'
        Given header Authorization = 'Token ' + token
        And param limit = 10
        And param offset = 0
        When method Get
        Then status 200
        And match response.articles[0].title != articleBody.article.title