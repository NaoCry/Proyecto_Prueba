Feature: Booking API - GetBookingIds Endpoint

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * def bookingIdItemSchema = read('classpath:schemas/booking/getBookingIdsItemSchema.json')
    * def getBookingResponseSchema = read('classpath:schemas/booking/getBookingResponseSchema.json')

  @booking @getbookingids @smoke @regression
  Scenario: Validar que el servicio GetBookingIds responde correctamente
    Given path '/booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == bookingIdItemSchema

  @booking @getbookingids @headers @contract @regression
  Scenario Outline: Validar envio de filtros opcionales por <parameter>
    * def endpoint = '/booking'
    * def query = {}
    * eval query[parameter] = value
    * print 'Request endpoint:', endpoint
    * print 'Request query params:', query
    Given path endpoint
    And params query
    When method GET
    Then status 200
    And match response == '#[]'
    * print 'Response body:', response
    * def invalidItems =
      """
      function(items) {
        var invalid = [];
        for (var i = 0; i < items.length; i++) {
          if (typeof items[i].bookingid !== 'number') {
            invalid.push({ index: i, value: items[i] });
          }
        }
        return invalid;
      }
      """
    * def invalidResults = invalidItems(response)
    And match invalidResults == []

    Examples:
      | parameter | value      |
      | firstname | Susan      |
      | lastname  | Brown      |
      | checkin   | 2014-03-13 |
      | checkout  | 2014-05-21 |

  @booking @getbooking @smoke @regression
  Scenario: Validar que GetBooking responde correctamente con ID valido
    Given path '/booking'
    When method GET
    Then status 200
    And match response == '#[]'
    And assert response.length > 0
    * def findAvailableBooking =
      """
      function(ids) {
        for (var i = 0; i < ids.length && i < 20; i++) {
          var id = ids[i].bookingid;
          for (var attempt = 0; attempt < 3; attempt++) {
            var probe = karate.call('classpath:features/helpers/get-booking-by-id.feature', { bookingId: id });
            if (probe.resultStatus == 200) {
              return { bookingId: id, booking: probe.resultBody };
            }
          }
        }
        return null;
      }
      """
    * def selectedBooking = findAvailableBooking(response)
    * match selectedBooking != null
    * match selectedBooking.bookingId == '#number'
    * print 'BookingID seleccionado para GetBooking:', selectedBooking.bookingId
    * print 'Response GetBooking:', selectedBooking.booking
    And match selectedBooking.booking == getBookingResponseSchema


  @booking @getbooking @negative @regression
  Scenario: Validar que GetBooking devuelve 404 para ID inexistente
    * def invalidBookingId = 99999999
    * print 'BookingID inexistente:', invalidBookingId
    Given path '/booking', invalidBookingId
    When method GET
    Then status 404



    