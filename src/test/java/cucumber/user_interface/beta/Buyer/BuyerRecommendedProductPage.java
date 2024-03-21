package cucumber.user_interface.beta.Buyer;

import net.serenitybdd.screenplay.targets.Target;

public class BuyerRecommendedProductPage {

    public static Target FILTER = Target.the("FILTER")
            .locatedBy("//div[@class='page recommended']//input[@placeholder='Select']");

}
