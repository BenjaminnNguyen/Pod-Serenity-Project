package testsuite.admin.logisticsPartner;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminLP",
        features = "src/test/resources/features/admin/logisticsPartner",
        glue = {"steps"}
)
public class AdminLPTestSuite {
}
