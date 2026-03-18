Feature: Booking API - CreateBooking Endpoint

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * def createBookingRequest = read('classpath:schemas/booking/createBookingRequestBody.json')
    * def createBookingResponseSchema = read('classpath:schemas/booking/createBookingResponseSchema.json')

  @booking @createbooking @smoke @regression
  Scenario: Validar que CreateBooking crea una reserva correctamente
    * print 'Request body CreateBooking:', createBookingRequest
    Given path '/booking'
    And request createBookingRequest
    When method POST
    Then status 200
    * print 'Response body CreateBooking:', response
    And match response == createBookingResponseSchema
    And match response.bookingid == '#number'
    And match response.booking.firstname == createBookingRequest.firstname
    And match response.booking.lastname == createBookingRequest.lastname
