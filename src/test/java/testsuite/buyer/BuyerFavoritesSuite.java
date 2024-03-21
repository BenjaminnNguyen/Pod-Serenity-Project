package testsuite.buyer;


import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=buyerFavorite",
        features = "src/test/resources/features/buyer/favorite",
        glue = {"steps"}
)
public class BuyerFavoritesSuite {
}
