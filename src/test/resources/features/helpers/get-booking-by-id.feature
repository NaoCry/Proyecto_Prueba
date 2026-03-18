Feature: Helper para consultar booking por id

  Scenario: Consultar booking por id sin asercion fija de status
    * url baseUrl
    * header Accept = 'application/json'
    Given path '/booking', bookingId
    When method GET
    * def resultStatus = responseStatus
    * def resultBody = response
