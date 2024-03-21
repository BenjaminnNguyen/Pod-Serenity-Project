package testsuite.vendor.storeList;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=vendorStoreList",
        features = "src/test/resources/features/vendor",
        glue = {"steps"}
)
public class VendorStoreListTestSuite {
}