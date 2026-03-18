Feature: Booking API - UpdateBooking Endpoint

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * def updateBookingRequest = read('classpath:schemas/booking/updateBookingRequestBody.json')
    * def updateBookingResponseSchema = read('classpath:schemas/booking/updateBookingResponseSchema.json')

  @booking @updatebooking @smoke @regression
  Scenario: Validar que UpdateBooking actualiza una reserva con autenticacion basica
    * def bookingId = 405

    * def auth = call read('classpath:features/helpers/basic-auth.js') { username: 'admin', password: 'password123' }
    * def updateInput =
      """
      {
        bookingId: '#(bookingId)',
        requestBody: '#(updateBookingRequest)',
        authHeader: '#(auth.value)'
      }
      """
    * def updatedPut = call read('classpath:features/helpers/put-booking-by-id.feature') updateInput
    * def updated = updatedPut.resultStatus == 405 ? karate.call('classpath:features/helpers/patch-booking-by-id.feature', updateInput) : updatedPut
    * if (updated.resultStatus != 200) karate.fail('No se actualizo la reserva. status=' + updated.resultStatus + ' body=' + updated.resultBody)
    And match updated.resultBody == updateBookingResponseSchema
    And match updated.resultBody.firstname == updateBookingRequest.firstname
    And match updated.resultBody.lastname == updateBookingRequest.lastname
    And match updated.resultBody.totalprice == updateBookingRequest.totalprice

    * def current = call read('classpath:features/helpers/get-booking-by-id.feature') { bookingId: '#(bookingId)' }
    And match current.resultStatus == 200
    And match current.resultBody.firstname == updateBookingRequest.firstname
    And match current.resultBody.lastname == updateBookingRequest.lastname
    And match current.resultBody.totalprice == updateBookingRequest.totalprice
