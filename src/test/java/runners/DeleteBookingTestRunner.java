package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class DeleteBookingTestRunner {
    @Test
    public void runDeleteBookingFeature() {
        Results results = Runner.path("classpath:features/delete-booking.feature")
                .tags("@deletebooking")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
