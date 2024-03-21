package cucumber.user_interface.beta.Buyer.orders;

import net.serenitybdd.screenplay.targets.Target;

public class OrderGuideForm {

    public static Target ORDER_GUIDE(String typeOrder) {
        return Target.the("'Type order'")
                .locatedBy("//div[@class='order']//span[text()='" + typeOrder + "']");
    }

    public static final Target SEARCH_TEXTBOX = Target.the("'Search textbox'")
            .locatedBy("//input[@placeholder='Search item code or Brand name']");

    public static final Target SEARCH_BUTTON = Target.the("'Search button'")
            .locatedBy("//div[@class='order']//i[contains(@class,'bx-search')]");

    public static final Target PRODUCT_IN_RESULT_SEARCH = Target.the("'Product in result search'")
            .locatedBy("//div[@class='preview']//div[@class='brand']//a");

    public static Target ADD_CART_BUTTON(String sku) {
        return Target.the("Add cart button").locatedBy(
                "//*[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-row']//button"
        );
    }

}
