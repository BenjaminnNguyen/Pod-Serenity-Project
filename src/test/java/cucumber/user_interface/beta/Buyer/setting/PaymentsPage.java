package cucumber.user_interface.beta.Buyer.setting;

import net.serenitybdd.screenplay.targets.Target;

public class PaymentsPage {

    public static final Target PAYMENTS_BUTTON = Target.the("Payment button")
            .locatedBy("//a[@href='/buyers/settings/payment']");

    public static final Target PAYMENT_HEADER = Target.the("Payment header")
            .locatedBy("//h1[text()='Payment Settings']");

    public static final Target DELETE_CURRENT_CART = Target.the("Delete current cart")
            .locatedBy("//span[text()='Current Payment Method']/following-sibling::div//div[contains(@class,'remove')]");

    public static final Target NO_CARD_ADDED = Target.the("No card bank account added")
            .locatedBy("//span[text()='No card/bank account added']");


}
