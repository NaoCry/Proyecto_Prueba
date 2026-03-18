Feature: Helper para actualizar booking por id usando patch

  Scenario: Actualizar booking por id sin asercion fija de status (patch)
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * header Authorization = authHeader
    Given path '/booking', bookingId
    And request requestBody
    When method PATCH
    * def resultStatus = responseStatus
    * def resultBody = response
