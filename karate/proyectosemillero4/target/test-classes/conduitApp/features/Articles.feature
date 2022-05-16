Feature: Articles
Background: precondiciones 
    Given url apiUrl
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
    * def token = tokenResponse.authToken
    * def requestBody = read ('classpath:conduitApp/json/requestbody.json')
    * def dataGenerator = Java.type('helpers.DataGenerate')
    * set requestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set requestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set requestBody.article.body = dataGenerator.getRandomArticleValues().body



Scenario: create Articles
    Given  path 'articles'
    And header Authorization = 'Token ' + token
    And request requestBody
    When method Post
    Then status 200    

Scenario: delete article
    Given  path 'articles'
    And header Authorization = 'Token ' + token
    And request requestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

   
    Given path 'articles'
    And params { limit: 10, offset : 0}
    And header Authorization = 'Token ' + token
    When method Get 
    Then status 200
    And match response.articles[0].title == requestBody.article.title


    Given  path 'articles',articleId
    And header Authorization = 'Token ' + token
    When method Delete
    Then status 204

    Given path 'articles'
    And params { limit: 10, offset : 0}
    And header Authorization = 'Token ' + token
    When method Get 
    Then status 200
    And match response.articles[0].title != requestBody.article.title
