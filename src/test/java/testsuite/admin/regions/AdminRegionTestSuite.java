package testsuite.admin.regions;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminRegion",
        features = "src/test/resources/features/admin/regions",
        glue = {"steps"}
)
public class AdminRegionTestSuite {
}
