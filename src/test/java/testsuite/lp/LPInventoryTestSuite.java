package testsuite.lp;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;


@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=LPInventory",
        features = "src/test/resources/features/lp",
        glue = {"steps"}
)
public class LPInventoryTestSuite {
}

