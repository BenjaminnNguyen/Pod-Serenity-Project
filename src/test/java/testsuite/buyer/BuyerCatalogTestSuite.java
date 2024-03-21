package testsuite.buyer;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyerCatalog",
        features = "src/test/resources/features/buyer/catalog",
        glue = {"steps"}
)
public class BuyerCatalogTestSuite {
}
