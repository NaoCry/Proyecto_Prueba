Feature: Booking API - PartialUpdateBooking Endpoint

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * def partialUpdateBookingRequest = read('classpath:schemas/booking/partialUpdateBookingRequestBody.json')
    * def partialUpdateBookingResponseSchema = read('classpath:schemas/booking/partialUpdateBookingResponseSchema.json')

  @booking @partialupdatebooking @smoke @regression
  Scenario: Validar que PartialUpdateBooking actualiza solo los campos enviados
    * def bookingId = 1105
    * def auth = call read('classpath:features/helpers/basic-auth.js') { username: 'admin', password: 'password123' }
    * def currentBeforeUpdate = call read('classpath:features/helpers/get-booking-by-id.feature') { bookingId: '#(bookingId)' }
    * if (currentBeforeUpdate.resultStatus != 200) karate.fail('No se encontro la reserva a actualizar parcialmente. status=' + currentBeforeUpdate.resultStatus + ' body=' + currentBeforeUpdate.resultBody)
    * def createdBooking = currentBeforeUpdate.resultBody
    * def partialUpdateInput =
      """
      {
        bookingId: '#(bookingId)',
        requestBody: '#(partialUpdateBookingRequest)',
        authHeader: '#(auth.value)'
      }
      """
    * def updated = call read('classpath:features/helpers/patch-booking-by-id.feature') partialUpdateInput
    * if (updated.resultStatus != 200) karate.fail('No se actualizo parcialmente la reserva. status=' + updated.resultStatus + ' body=' + updated.resultBody)
    And match updated.resultBody == partialUpdateBookingResponseSchema
    * def current = call read('classpath:features/helpers/get-booking-by-id.feature') { bookingId: '#(bookingId)' }
    And match current.resultStatus == 200
    And match current.resultBody.firstname == partialUpdateBookingRequest.firstname
    And match current.resultBody.lastname == partialUpdateBookingRequest.lastname
    And match current.resultBody.totalprice == createdBooking.totalprice
    And match current.resultBody.depositpaid == createdBooking.depositpaid
    And match current.resultBody.bookingdates == createdBooking.bookingdates
    And match current.resultBody.additionalneeds == createdBooking.additionalneeds
