package testsuite.buyer.addtocart;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=addToCart",
        features = "src/test/resources/features/buyer/addToCart",
        glue = {"steps"}
)
public class AddToCartTestSuite {
}