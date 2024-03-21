package testsuite.important;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=important-flow",
        features = "src/test/resources/features",
        glue = {"steps"}
)
public class ImportantFlowTestSuite {
}
