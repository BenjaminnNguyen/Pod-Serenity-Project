package testsuite.admin;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminNewCreateBrandProductSKU",
        features = "src/test/resources/features/admin",
        glue = {"steps"}
)
public class AdminTestSuite {
}
