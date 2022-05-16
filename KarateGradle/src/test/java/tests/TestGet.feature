Feature: Sample Api Test get

  Background:
    * url 'https://reqres.in/api'
    * header Accept = 'application/json'

  @skipme
  Scenario: Test sample Get 1
    Given url 'https://reqres.in/api/users?page=2'
    When method GET
    Then status 200
    And print response

  @smoke
  Scenario: Test sample Get 2
    Given path '/users?page=2'
    When method GET
    Then status 200
    And print response
  @skipme
  Scenario: Test sample Get 3
    Given path '/users'
    And param page = 2
    When method GET
    Then status 200
    And print response

  Scenario: Test sample Get 4
    Given path '/users'
    And param page = 2
    When method GET
    Then status 200
    And match response.data[0].first_name == 'Michael'
    And assert response.data.length == 6
    And match $.data[1].id == 8
    And match $.data[3].last_name == 'Fields'

