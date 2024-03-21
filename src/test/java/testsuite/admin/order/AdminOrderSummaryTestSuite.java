package testsuite.admin.order;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminOrderSummary",
        features = "src/test/resources/features/admin/order",
        glue = {"steps"}
)
public class AdminOrderSummaryTestSuite {
}
