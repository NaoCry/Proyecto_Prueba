package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class AuthTestRunner {
    @Test
    public void runAuthFeatures() {
        Results results = Runner.path("classpath:features/auth.feature")
                .tags("@auth")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
