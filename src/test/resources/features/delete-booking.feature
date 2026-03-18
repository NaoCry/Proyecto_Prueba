Feature: Booking API - DeleteBooking Endpoint

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  @booking @deletebooking @smoke @regression
  Scenario: Validar que DeleteBooking elimina una reserva con autenticacion basica
    * def bookingId = 1105
    * def auth = call read('classpath:features/helpers/basic-auth.js') { username: 'admin', password: 'password123' }
    * def currentBeforeDelete = call read('classpath:features/helpers/get-booking-by-id.feature') { bookingId: '#(bookingId)' }
    * if (currentBeforeDelete.resultStatus != 200) karate.fail('No se encontro la reserva a eliminar. status=' + currentBeforeDelete.resultStatus + ' body=' + currentBeforeDelete.resultBody)
    * def deleteInput =
      """
      {
        bookingId: '#(bookingId)',
        authHeader: '#(auth.value)'
      }
      """
    * def deleted = call read('classpath:features/helpers/delete-booking-by-id.feature') deleteInput
    * if (deleted.resultStatus != 201) karate.fail('No se elimino la reserva. status=' + deleted.resultStatus + ' body=' + deleted.resultBody)
    * def currentAfterDelete = call read('classpath:features/helpers/get-booking-by-id.feature') { bookingId: '#(bookingId)' }
    And match currentAfterDelete.resultStatus == 404
    And match currentAfterDelete.resultBody == 'Not Found'
