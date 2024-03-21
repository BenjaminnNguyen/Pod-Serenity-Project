package testsuite.taxes;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=tax",
        features = "src/test/resources/features/admin/tax",
        glue = {"steps"}
)
public class TaxesTestSuite {
}
