Feature: Sample Api Test post

  Background:
    * url 'https://reqres.in/api'
    * header Accept = 'application/json'
    * def expectedOutput = read('response1.json')


# Simple Post scenario
  Scenario: Post  1
    Given url 'https://reqres.in/api/users'
    And request { "name": "johann", "job": "Leader"}
    When method post
    And print response
    Then status 201


# Post scenario with Background
  Scenario: Post 2
    Given path '/users'
    And request { "name": "Johann", "job": "leader"}
    When method post
    Then status 201


  # Post with response assertion
  Scenario: Post 3
    Given path '/users'
    And request { "name": "Johann", "job": "leader"}
    When method post
    Then status 201
    And match response == {"name": "Johann", "job": "leader","id": "#string","createdAt": "#ignore"}



 # Post with response matching from file
  Scenario: Post 4
    Given path '/users'
    And request { "name": "Johann", "job": "leader"}
    When method post
    Then status 201
    And print response
    And match response == expectedOutput
    And match $ == expectedOutput
