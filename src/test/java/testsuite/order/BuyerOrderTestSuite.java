package testsuite.order;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyerOrder",
        features = "src/test/resources/features/buyer/orders",
        glue = {"steps"}
)
public class BuyerOrderTestSuite {
}
