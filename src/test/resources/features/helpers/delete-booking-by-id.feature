Feature: Helper para eliminar booking por id

  Scenario: Eliminar booking por id sin asercion fija de status
    * url baseUrl
    * header Accept = 'application/json'
    * header Authorization = authHeader
    Given path '/booking', bookingId
    When method DELETE
    * def resultStatus = responseStatus
    * def resultBody = response
