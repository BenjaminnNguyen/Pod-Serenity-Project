package cucumber.user_interface.beta.Buyer.promotion;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class PromotionsPage {

    public static Target PROMOTIONS(String tab) {
        return Target.the("Tab " + tab)
                .located(By.xpath("//a[text()='" + tab + "']"));
    }

    public static Target BRAND_TEXTBOX = Target.the("Brand textbox")
            .located(By.xpath("//div[text()='Brand']/following-sibling::div//input"));

    public static Target ORDERED_BRAND = Target.the("Ordered brand dropdown")
            .located(By.xpath("//div[text()='Ordered brands']/following-sibling::div//input"));

    public static Target TIME_DROPDOWN = Target.the("Time dropdown")
            .located(By.xpath("//div[text()='Time']/following-sibling::div//input"));

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the("Item " + value)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target SHOW_DETAILS(int i) {
        return Target.the("Show detail button")
                .located(By.xpath("(//button//span[text()='Show Details'])[" + i + "]"));

    }

    public static Target HIDE_DETAILS = Target.the("Show detail button")
            .located(By.xpath("//span[normalize-space()='Hide']"));

    public static Target NO_APPLIED_PRODUCT_FOUND = Target.the("No applied product found")
            .located(By.xpath("//p[text()='No applied product found.']"));


    public static Target TYPE_PROMO(int i) {
        return Target.the("Type promo")
                .located(By.xpath("(//div[@class='promotion-tag'])[" + i + "]"));
    }

    public static Target PRICE_PROMOTED = Target.the("Price promoted")
            .located(By.xpath("//div[@class='price']/span[@class='current promoted']"));

    public static Target HIDE_BUTTON = Target.the("Hide button")
            .located(By.xpath("//div[@class='hide']"));

    public static Target MININUM_PURCHASE = Target.the("Mininum purchase")
            .located(By.xpath("(//dt[text()='Mininum purchase']/following-sibling::dd/strong)[1]"));

    public static Target LIMITED_TO = Target.the("Limited to")
            .located(By.xpath("(//dt[contains(text(),'Limited to')]/following-sibling::dd/strong)[1]"));

    public static Target SKU_EXPIRY_DATE = Target.the("Limited to")
            .located(By.xpath("(//dt[contains(text(),'SKU expiry date:')]/following-sibling::dd/strong)[1]"));

    public static Target STACK_CASE_DETAIL(int i) {
        return Target.the("STACK_CASE_DETAIL")
                .located(By.xpath("//div[@class='case-stack-promotion']//div[" + i + "]"));
    }

    public static Target STACK_CASE_DETAIL_CART_DETAIL() {
        return Target.the("STACK_CASE_DETAIL")
                .located(By.xpath("//span[text()='Case Stack Deals']/following-sibling::span"));
    }

    public static Target EFFECTIVE_DATE = Target.the("Limited to")
            .located(By.xpath("//div[text()='Effective date']/following-sibling::span"));

    public static Target NO_PROMOTION_FOUND = Target.the("Text No promotion request found...")
            .located(By.xpath("//span[text()='No promotions requests found...']"));

    public static Target TOTAL_PROMOTION_TEXT = Target.the("Total promotion")
            .located(By.xpath("//div[@class='edt-piece amount fw-normal']"));

    public static Target TEXT_ORDER_BEFORE = Target.the("Text order before")
            .located(By.xpath("//div[contains(text(),'You ordered this brand before.')]"));

    public static Target SKU_IN_DETAIL = Target.the("SKU in detail")
            .located(By.xpath("//div[@class='variant']/a"));

    public static Target PRODUCT_IN_DETAIL = Target.the("Product in detail")
            .located(By.xpath("//div[@class='products']/a"));

    public static Target D_ADD_TO_CART(String skuName) {
        return Target.the("Button add to cart of " + skuName)
                .located(By.xpath("//a[text()='" + skuName + "']//ancestor::div[@class='edt-row']//following-sibling::div//button[contains(@class,'add-to-cart')]"));
//                .located(By.xpath("//a[text()='AT SKU Promo26']//ancestor::div//following-sibling::div//button[contains(@class,'add-to-cart')]"));
    }

    public static Target BRAND_IN_PROMO_TAB(String brand) {
        return Target.the("Brand in header of promo tab")
                .located(By.xpath("//div[@class='el-card__header']//strong[text()='" + brand + "']"));

    }

    //popup
    public static Target POPUP_CONFIRM = Target.the("Popup confirm")
            .located(By.xpath("//div[@role='dialog']//span[text()='Confirm']"));

    public static Target POPUP_CONFIRM_BUTTON = Target.the("Popup confirm button")
            .located(By.xpath("//button//span[normalize-space()='I understand']"));

    public static Target MESSAGE_ADD_TO_CART = Target.the("Message Item added to cart!")
            .located(By.xpath("//p[text()='Item added to cart!']"));

}
