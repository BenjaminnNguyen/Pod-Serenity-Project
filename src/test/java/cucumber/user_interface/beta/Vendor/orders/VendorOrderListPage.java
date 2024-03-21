package cucumber.user_interface.beta.Vendor.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorOrderListPage {
    public static Target TYPE_ORDER(String type) {
        return Target.the("Type Orders " + type)
                .locatedBy("//div[@class='label']//span[text()='" + type + "']");
    }


    public static Target ORDER_BY_ID(String idInvoice) {
        return Target.the("Order by id invoice")
                .located(By.xpath("//div[@class='orders-list']//div[text()='" + idInvoice + "']"));
    }

    public static Target LOADING_SPINNER = Target.the("Loading spinner")
            .located(By.xpath("//div[@class='loading--indicator']"));

    public static Target SHOW_INFO_ORDER = Target.the("Show general information button")
            .located(By.xpath("//button/span[text()='Show general information']"));

    public static Target CURRENT_PRICE_PROMO = Target.the("Current price promo")
            .located(By.xpath("//div[@class='total']/div[@class='current']"));

    public static Target PROMOTION_DICOUNT = Target.the("Promotion discount")
            .located(By.xpath("//div[@class='promotion negative']"));

//    public static Target SPECIAL_PROMOTION_DICOUNT = Target.the("Secial Promotion discount")
//            .located(By.xpath("//div[@class='text-right negative special-discount']"));

    public static Target NO_ORDER_FOUND = Target.the("No order found")
            .located(By.xpath("//span[normalize-space()='No orders found...']"));

    public static Target NUMBER_PAGE = Target.the("Number page")
            .located(By.xpath("//li[contains(@class,'number')]"));

    /**
     * Search
     */

    public static Target DYNAMIC_TEXTBOX_SEARCH(String name) {
        return Target.the("Textbox " + name)
                .located(By.xpath("//label[text()='" + name + "']/following-sibling::div//input"));

    }

    public static Target DYNAMIC_TEXTBOX_SEARCH_ALL(String name) {
        return Target.the("Textbox " + name)
                .located(By.xpath("//div[@class='form']//label[text()='" + name + "']/following-sibling::div//input"));
    }

    public static Target COUNTER(String tab) {
        return Target.the("counter on " + tab)
                .located(By.xpath("(//div[contains(@class,'tab')]//span[text()='" + tab + "']/preceding-sibling::span[@class = 'counter'])"));
    }

    public static Target CLOSE_SEARCH_ALL = Target.the("Close Search ")
            .located(By.xpath("//i[@class='el-dialog__close el-icon el-icon-close']"));

    public static Target SEARCH_ALL = Target.the(" Search All")
            .located(By.xpath("//div[@class='field more']//span"));

}
