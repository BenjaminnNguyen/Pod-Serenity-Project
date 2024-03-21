package testsuite.admin.brand;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminBrand",
        features = "src/test/resources/features/admin/brands",
        glue = {"steps"}
)
public class AdminBrandTestSuite {
}
