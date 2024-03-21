package testsuite.admin.claims;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminVendorClaims",
        features = "src/test/resources/features/admin/claims",
        glue = {"steps"}
)
public class AdminVendorClaimsTestSuite {
}
