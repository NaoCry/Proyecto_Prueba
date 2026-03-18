package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class BookingTestRunner {
    @Test
    public void runBookingFeatures() {
        Results results = Runner.path("classpath:features/booking.feature")
                .tags("@booking")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
