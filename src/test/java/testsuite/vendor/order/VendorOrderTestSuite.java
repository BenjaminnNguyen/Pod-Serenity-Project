package testsuite.vendor.order;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;


@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=vendorOrders",
        features = "src/test/resources/features/vendor/order",
        glue = {"steps"}
)
public class VendorOrderTestSuite {
}

