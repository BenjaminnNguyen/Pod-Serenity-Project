package testsuite.buyer;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyer-cart-checkout",
        features = "src/test/resources/features/buyer/cartCheckout",
        glue = {"steps"}
)
public class BuyerCartCheckoutTestSuite {
}
