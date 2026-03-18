package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestRunner {
    @Test
    public void runAllFeatures() {
        Results results = Runner.path("classpath:features")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
