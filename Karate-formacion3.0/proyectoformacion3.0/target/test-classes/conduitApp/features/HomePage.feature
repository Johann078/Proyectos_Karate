Feature:Tests for the Home page

Background: Define URL
    Given url apiURL
    * def tokenResponse = callonce read('classpath:helpers/Login.feature')
    * def token = tokenResponse.authToken
    * header Authorization = 'Token ' + token 
Scenario: Get All Tags
    
    Given path 'tags'
    When method Get
    Then status 200
    Then match response.tags contains ['Test2','karate']
    And match response.tags !contains 'carro'
    And match response.tags contains any ['perro','pato','karate']
    And match response.tags == '#array'
    And match each response.tags == '#string'

Scenario: Get articles frome page 
    * def timevalidator = read('classpath:helpers/time-validator.js')
    Given path 'articles'
    # And header Authorization = 'Token ' + token  
    # Given param limit = 10
    # Given param offset = 0
    Given params { limit : 10 , offset : 0 }
    When method Get 
    Then status 200
    And match response.articles == '#5'
    And match response.articlesCount == 5
    And match response  == {"articles":'#5',"articlesCount": 5}
    And match response.articlesCount  !=  10000

    And match response.articles[0].createdAt contains '04'
    # And match response.articles[*].favoritesCount contains 887
    And match response.articles[*].favoritesCount contains '#number'
    And match response..bio contains null
    And match response..bio contains '##string'
    And match response..following contains false
    And match response..following contains '#boolean'
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

