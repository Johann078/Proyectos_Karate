package apiAutomation;

// import com.intuit.karate.Results;
// import com.intuit.karate.Runner;
// import static org.junit.jupiter.api.Assertions.*;
// import org.junit.jupiter.api.Test;
import com.intuit.karate.junit5.Karate;

class ExamplesTest {

    // @Test
    // void testParallel() {
    //     Results results = Runner.path("classpath:examples")
    //             //.outputCucumberJson(true)
    //             .parallel(5);
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    // }
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}
