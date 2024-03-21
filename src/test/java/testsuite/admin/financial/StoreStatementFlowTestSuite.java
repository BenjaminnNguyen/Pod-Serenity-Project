package testsuite.admin.financial;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=StoreStatement-flow",
        features = "src/test/resources/features/admin/financial/storeStatement",
        glue = {"steps"}
)
public class StoreStatementFlowTestSuite {
}
