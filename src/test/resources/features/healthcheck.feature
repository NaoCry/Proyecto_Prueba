Feature: Booking API - HealthCheck Endpoint

  Background:
    * url baseUrl
    * header Accept = 'text/plain'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  @healthcheck @smoke
  Scenario: Validar que el servicio responde al healthcheck
    Given path '/ping'
    When method GET
    Then status 201
    And match response == 'Created'
