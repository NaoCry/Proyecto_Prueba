package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PartialUpdateBookingTestRunner {
    @Test
    public void runPartialUpdateBookingFeature() {
        Results results = Runner.path("classpath:features/partial-update-booking.feature")
                .tags("@partialupdatebooking")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
