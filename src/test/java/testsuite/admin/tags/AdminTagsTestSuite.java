package testsuite.admin.tags;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminTags",
        features = "src/test/resources/features/admin/tags",
        glue = {"steps"}
)
public class AdminTagsTestSuite {
}
