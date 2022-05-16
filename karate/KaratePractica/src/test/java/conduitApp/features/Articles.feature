Feature: Articulos

Background: Preconditions
    * def articleResquesBody = read ('classpath:conduitApp/json/newArticles.json')
    * def dataGenerator = Java.type('helpers.DataGenerate')
    * set articleResquesBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleResquesBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleResquesBody.article.body = dataGenerator.getRandomArticleValues().body
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
    * def token = tokenResponse.authToken
    * url  apiUrl
@ignore
Scenario: Create New Article 
    
    Given path 'articles'
    And header Authorization = 'Token ' + token
    And request articleResquesBody
    When method Post
    Then status 200 

Scenario: Delete Article
    
    Given path 'articles'
    And header Authorization = 'Token ' + token
    And request articleResquesBody
    When method Post
    Then status 200
    * def slug = response.article.slug
    
    Given path 'articles'
    Given params { limit:10 , offset:0}
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title == articleResquesBody.article.title

    Given path 'articles',slug
    And header Authorization = 'Token ' + token
    When method Delete
    Then status 204

    Given path 'articles'
    Given params { limit:10 , offset:0}
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[0].title != articleResquesBody.article.title

