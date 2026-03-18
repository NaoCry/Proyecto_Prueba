package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class HealthCheckTestRunner {
    @Test
    public void runHealthCheckFeature() {
        Results results = Runner.path("classpath:features/healthcheck.feature")
                .tags("@healthcheck")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
