package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class UpdateBookingTestRunner {
    @Test
    public void runUpdateBookingFeature() {
        Results results = Runner.path("classpath:features/update-booking.feature")
                .tags("@updatebooking")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
