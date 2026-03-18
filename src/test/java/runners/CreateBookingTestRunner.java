package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CreateBookingTestRunner {
    @Test
    public void runCreateBookingFeature() {
        Results results = Runner.path("classpath:features/create-booking.feature")
                .tags("@createbooking")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
