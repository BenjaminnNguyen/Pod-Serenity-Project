package testsuite.admin.store;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminStore",
        features = "src/test/resources/features/admin/store",
        glue = {"steps"}
)

public class AdminStoreTestSuite {
}
