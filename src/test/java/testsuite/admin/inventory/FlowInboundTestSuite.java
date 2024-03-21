package testsuite.admin.inventory;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=inbound-flow",
        features = "src/test/resources/features/admin/inventories",
        glue = {"steps"}
)
public class FlowInboundTestSuite {
}
