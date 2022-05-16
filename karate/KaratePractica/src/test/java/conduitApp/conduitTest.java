package conduitApp;

import com.intuit.karate.junit5.Karate;

class conduitTest {


@Karate.Test
Karate TestAll(){
    return Karate.run().relativeTo(getClass());
}
}
