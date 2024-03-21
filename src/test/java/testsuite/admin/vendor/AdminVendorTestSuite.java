package testsuite.admin.vendor;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminVendor",
        features = "src/test/resources/features/admin/vendor",
        glue = {"steps"}
)
public class AdminVendorTestSuite {
}
