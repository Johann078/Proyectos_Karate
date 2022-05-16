Feature: Tests for the home page
Background: precondiciones 
    Given url apiUrl
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
    * def token = tokenResponse.authToken


Scenario: get all tags

    Given  path 'tags'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.tags contains ["test","codebaseShow",]
    And match response.tags !contains ["carro","mesa"]
    And match response.tags contains any ["carro","avion","test"]
    And match response.tags == '#array'
    And match each response.tags == '#string'


 Scenario:  Get articles from the page 
    * def timevalidator = read ('classpath:helpers/time-validator.js')
    
    Given path 'articles'
    # Given param limit = 10
    # Given param offset = 0 
    And params { limit: 10, offset : 0}
    And header Authorization = 'Token ' + token
    When method Get 
    Then status 200
    # And match response.articles == '#[10]'
    # And match response == {"articles":'#[10]',"articlesCount": 11}
    And match response.articlesCount == 11
    And match response.articlesCount != 100

    And match response.articles[0].createdAt contains "2022"
    And match response.articles[*].favoritesCount contains 488
    # And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match response..bio contains '##string'
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    
    And  match each response.articles ==
    """
    {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#? timevalidator(_)",
            "updatedAt": "#? timevalidator(_)",
            "tagList": "#array",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            },
            "favoritesCount": "#number",
            "favorited": "#boolean"
        }
    """
    

    
