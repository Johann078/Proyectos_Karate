Feature: Tests for the Home Page

Background: Define URL
    * url apiUrl
    * def tokenRepsonse = callonce read('classpath:helpers/Login.feature')
    * def token = tokenRepsonse.authToken

Scenario: Get all tags
   
    Given path 'tags'
    Given header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.tags contains ['karate','Formacion']
    And match response.tags !contains 'Calculadora'
    And match response.tags contains any ['pescado','Test','perro']
    And match response.tags == '#array'
    And match each response.tags == '#string'
Scenario: Get articles from the page 

    Given params { limit:10, offset:0}
    Given header Authorization = 'Token ' + token
    Given path 'Articles'
    When method Get
    Then status 200 

