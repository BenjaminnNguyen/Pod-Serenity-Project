package cucumber.user_interface.beta.Buyer.orders;


import net.serenitybdd.screenplay.targets.Target;

public class BuyerOrderGuildPage {
    public static Target SEARCH_BRAND = Target.the("Search brand field")
            .locatedBy("//input[@placeholder='Search item code or Brand name']");

    public static Target BRAND_NAME (int i){
        return Target.the(" brand name")
                .locatedBy("(//div[@class='brand'])["+i+"]");
    }

    public static Target PRODUCT_NAME  (int i){
        return Target.the(" product name")
                .locatedBy("(//div[@class='product'])["+i+"]");
    }

    public static Target SKU_NAME(int i){
        return Target.the(" sku name")
                .locatedBy("(//div[@class='info-variant__name'])["+i+"]");
    }

    public static Target UNIT_PER_CASE(int i) {
        return Target.the("Unit per case")
                .locatedBy("(//div[@class='variants-item']//div[@class='edt-piece unit-per-case'])["+i+"]");
    }

    public static Target ORDER_DATE (int i) {
        return Target.the("Previous orders date")
                .locatedBy("(//dl[@class='metas']/dt)["+i+"]");
    }

    public static Target QUANTITY (int i) {
        return Target.the("Quantity")
                .locatedBy("(//dl[@class='metas']/dd)["+i+"]");
    }
    
    public static Target ADD_TO_CART_BUTTON(int i) {
        return Target.the("Add to cart button")
                .locatedBy("(//div[@class='edt-piece action pf-nowrap']/button)["+i+"]");
    }
}
