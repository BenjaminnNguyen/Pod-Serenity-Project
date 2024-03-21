package testsuite.buyer.claims;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=BuyerClaims",
        features = "src/test/resources/features/buyer/claims",
        glue = {"steps"}
)
public class BuyerClaimsTestSuite {
}
