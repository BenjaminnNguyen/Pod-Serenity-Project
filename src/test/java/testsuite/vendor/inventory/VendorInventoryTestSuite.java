package testsuite.vendor.inventory;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;


@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=vendorInventory",
        features = "src/test/resources/features/vendor/inventory",
        glue = {"steps"}
)
public class VendorInventoryTestSuite {
}

