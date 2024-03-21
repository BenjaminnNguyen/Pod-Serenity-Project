package testsuite.buyer.brand;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyerBrand",
        features = "src/test/resources/features/buyer/brand",
        glue = {"steps"}
)
public class BuyerBrandTestSuite {
}
