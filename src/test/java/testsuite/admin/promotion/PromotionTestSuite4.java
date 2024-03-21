package testsuite.admin.promotion;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=Promotion4",
        features = "src/test/resources/features/admin/promotion",
        glue = {"steps"}
)
public class PromotionTestSuite4 {
}
