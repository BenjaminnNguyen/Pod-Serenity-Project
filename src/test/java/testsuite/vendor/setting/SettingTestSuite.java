package testsuite.vendor.setting;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;


@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=Setting and @!",
        features = "src/test/resources/features/vendor/setting",
        glue = {"steps"}
)
public class SettingTestSuite {
}

