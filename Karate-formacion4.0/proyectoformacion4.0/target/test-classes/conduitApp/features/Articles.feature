Feature: Articles

Background: Set URL
    Given  url apiURL
    * def tokenResponse = callonce read('classpath:helpers/Login.feature')
    * def articleResquestBody = read('classpath:helpers/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerate')
    * set articleResquestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleResquestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleResquestBody.article.body = dataGenerator.getRandomArticleValues().body
    
Scenario:Create Article and Delete

    Given path 'articles'
    * def token = tokenResponse.authToken

    And header Authorization = 'Token ' + token
    And request articleResquestBody
    When method Post
    Then status 200
    * def slug = response.article.slug

    Given params {limit : 10, offset : 0} 
    Given path 'articles'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title == articleResquestBody.article.title


    Given path 'articles',slug
    * def token = tokenResponse.authToken
    And header Authorization = 'Token ' + token
    When method Delete
    Then status 204

    Given params {limit : 10, offset : 0} 
    Given path 'articles'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title != articleResquestBody.article.title


