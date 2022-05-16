Feature: Tests for the home Page

Background: Set URL
    Given  url apiURL
    * def tokenResponse = callonce read('classpath:helpers/Login.feature')
    * def token = tokenResponse.authToken
Scenario:Get all tags 
  
    Given path 'tags'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.tags contains ['karate','Formacion'] 
    And match response.tags !contains 'simulador'
    And match response.tags contains any ['pato','perro','karate']
    And match response.tags == '#array'
    And match each response.tags == '#string' 


Scenario:Get all Articles 
    * def timevalidator = read('classpath:helpers/time-validator.js')
    Given params {limit : 10, offset : 0} 
    Given path 'articles'
    And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    # And match response.articles == '#[4]'
    # And match response.articlesCount == 4
    And match response ==  {"articles":'#[5]',"articlesCount": 5}
    And match response.articlesCount != 100

    And match response.articles[0].createdAt contains '2022'
    And match response.articles[*].favoritesCount contains 866 
    # And match response.articles[*].author.bio contains null

    And match response..bio contains null
    And match response..bio contains '##string'
    And match each response..following == '#boolean' 
    And match each response.articles ==
    """
        {
            "slug": '#string',
            "title": '#string',
            "description": '#string',
            "body": '#string',
            "createdAt":'#? timevalidator(_)',
            "updatedAt":'#? timevalidator(_)',
            "tagList":'#array',
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