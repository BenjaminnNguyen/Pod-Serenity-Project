package testsuite.admin.changeRequest;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminChangeRequest",
        features = "src/test/resources/features/admin/changeRequest",
        glue = {"steps"}
)
public class AdminChangeRequestTestSuite {
}
