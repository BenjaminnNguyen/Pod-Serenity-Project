package testsuite.admin.buyers;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminBuyer",
        features = "src/test/resources/features/admin/buyers",
        glue = {"steps"}
)
public class AdminBuyerTestSuite {
}
