package testsuite.admin.product;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminProductFeature",
        features = "src/test/resources/features/admin/products",
        glue = {"steps"}
)
public class AdminProductSuite {

}
