Feature: Auth API - CreateToken Endpoint

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * def validBody = read('classpath:schemas/auth/createTokenDefaultBody.json')

  @happy-path @smoke @regression @auth
  Scenario: Validar que el servicio auth responde correctamente
    * def requestBody = validBody
    Given path '/auth'
    And request requestBody
    When method POST
    Then status 200

  @auth @createtoken @regression
  Scenario: Validar generacion correcta del token
    * def requestBody = validBody
    * print 'Request body:', requestBody
    Given path '/auth'
    And request requestBody
    When method POST
    Then status 200
    * print 'Token generado:', response.token
    And match response.token == '#string'
