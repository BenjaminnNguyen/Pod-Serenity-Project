package testsuite.admin.sampleRequest;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminSampleRequest",
        features = "src/test/resources/features/admin/sampleRequest",
        glue = {"steps"}
)
public class AdminSampleRequestTestSuite {
}
