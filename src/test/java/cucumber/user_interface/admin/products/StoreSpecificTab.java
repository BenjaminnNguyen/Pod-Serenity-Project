package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class StoreSpecificTab {

    public static Target STORE_SPECIFIC_TAB = Target.the("Store Specific tab")
            .located(By.cssSelector("#tab-stores"));

    public static Target BUYER_COMPANY_SPECIFIC_TAB = Target.the("Buyer company Specific tab")
            .located(By.cssSelector("#tab-buyers"));

    public static Target BUYER_COMPANY_FIELD = Target.the("Buyer company Specific field")
            .located(By.xpath("//input[@placeholder='Select buyer company']"));

    public static Target ADD_REGION_COMBO = Target.the("Region field")
            .located(By.xpath("//div[text()='Add a store:']/following-sibling::div//input"));
    public static Target SEARCH_STORE = Target.the("")
            .located(By.xpath("//div[text()='Add a store:']/following-sibling::div[2]//input"));
    public static Target ADD_BUTTON = Target.the("add button")
            .located(By.xpath("//span[normalize-space()='Add']"));

    public static Target ADD_MULTIPLE_BUTTON = Target.the("")
            .located(By.xpath("//button[contains(@class,'addMutipleformBtn')]//span[normalize-space()='Add']"));

    public static Target STORE_NAME = Target.the("")
            .located(By.xpath("//span[@class='store']"));

    public static Target STORE_NAME(String name) {
        return Target.the("")
                .located(By.xpath("//span[@class='store' and text()='" + name + "']"));
    }

    public static Target DYNAMIC_FIELD_INPUT(String store, String field) {
        return Target.the("field " + field + "of store" + store)
                .located(By.xpath("//span[contains(text(),'" + store + "')]/parent::td/following-sibling::td//div[contains(@class,'" + field + "')]//input"));
    }

    public static Target CASE_PRICE_FIELD = Target.the("CASE_PRICE_FIELD")
            .located(By.xpath("(//div[contains(@class,'store-case-price-cents')]//input[@type='number'])[last()]"));

    public static Target MSRP_UNIT_FIELD = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'store-msrp-cents')]//input[@type='number'])[last()]"));

    public static Target AVAILABILITY = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'availability')]//input)[last()]"));

    public static Target START_DATE = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'start-date')]//input)[last()]"));

    public static Target END_DATE = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'end-date')]//input)[last()]"));

}

