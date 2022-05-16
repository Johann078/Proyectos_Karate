Feature: Tests for the home page

Background: Preconditions
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
    * def token = tokenResponse.authToken
    * url  apiUrl

Scenario: Get all tags 
    
    Given path 'tags'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200 
    # And print response
    And match response.tags contains ['karate','Formacion','Test']
    And match response.tags !contains 'prueba3'
    And match response.tags contains any ['pescado','inocentes','karate']
    And match response.tags == '#array'
    And match each response.tags == '#string'


Scenario: Get articles from page 
    * def timevalidator = read ('classpath:helpers/time-validator.js')
    
    Given path 'articles'
    # Given params limit = 10
    # Given params offset = 0
    Given params { limit:10 , offset:0}
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    # And match response.articles == '#[10]'
    And match response == {"articles":'#[4]',"articlesCount": 4}
    And match response.articlesCount == 4
    And match response.articlesCount != 100

    # And match response.articles[0].createdAt contains '2021'
    # And match response.articles[*].favoritesCount contains 1
    # And match response.articles[*].author.bio contains null
    And match response..bio contains null
      And match response..bio contains '##string'
       And match each response..favorited == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response.articles ==
    """
        {
            "slug": '#string',
                "title": '#string',
                "description": '#string',
            "body": '#string',
            "createdAt": '#? timevalidator(_)',
            "updatedAt": '#? timevalidator(_)',
            "tagList": '#array',
            "author": {
                "username": '#string',
                "bio": '##string',
                "image": '#string',
                "following": '#boolean'
            },
            "favoritesCount": '#number',
            "favorited": '#boolean'
        }
    """