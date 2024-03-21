package testsuite.admin.feesTaxes;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminFeesTaxes and @AD_FEES_TAXES_37",
        features = "src/test/resources/features/admin/feesTaxes",
        glue = {"steps"}
)
public class AdminFeesTaxesTestSuite {
}
