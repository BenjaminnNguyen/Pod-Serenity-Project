package testsuite.order;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyer-PreOrder",
        features = "src/test/resources/features/buyer/preOrders",
        glue = {"steps"}
)
public class BuyerPreOrderTestSuite {
}
