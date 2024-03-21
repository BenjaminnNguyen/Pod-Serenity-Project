package testsuite.buyer;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyerRecommendedProduct",
        features = "src/test/resources/features/buyer/recommendedProduct",
        glue = {"steps"}
)
public class BuyerRecommendedProductTestSuite {
}
