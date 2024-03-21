package testsuite.vendor.sampleRequest;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=vendorSampleRequest",
        features = "src/test/resources/features/vendor/sampleRequest",
        glue = {"steps"}
)
public class VendorSampleRequestTestSuite {
}
