package testsuite;

import io.cucumber.core.options.Constants;
import org.junit.platform.suite.api.*;

import static io.cucumber.core.options.Constants.*;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@IncludeTags({"B_PRODUCT_DETAILS_114"})
//@IncludeTags("test")
//@ConfigurationParameter(key = FEATURES_PROPERTY_NAME, value = "src/test/resources/features/admin/inventories/inventoryFlow.feature")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "steps")
//@ConfigurationParameter(key = FILTER_TAGS_PROPERTY_NAME, value = "@feature=AdminOrderSummary and @test")

public class Cucumber1TestSuite {

}
   // mvn clean verify -Dtestsuite="Cucumber1TestSuite" -Dcucumber.options="src/test/resources/features/admin/inventories" -Dgroups="Inventory"
   // mvn clean verify -Dgroups="feature=flow-inventory" -Dcucumber.execution.parallel.config.fixed.max-pool-size=1
   // mvn clean verify  -Dtestsuite="Cucumber1TestSuite" -Dgroups="Inventory"

