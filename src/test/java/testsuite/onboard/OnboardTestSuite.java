package testsuite.onboard;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=onboarding",
        features = "src/test/resources/features/onboard",
        glue = {"steps"}
)
public class OnboardTestSuite {
}
