package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class BuyerCompanySpecificTap {

    public static Target STORE_SPECIFIC_TAB = Target.the("Store Specific tab")
            .located(By.cssSelector("#tab-stores"));

    public static Target BUYER_COMPANY_SPECIFIC_TAB = Target.the("Buyer company Specific tab")
            .located(By.cssSelector("#tab-buyers"));

    public static Target BUYER_COMPANY_FIELD = Target.the("Buyer company Specific field")
            .located(By.xpath("//input[@placeholder='Select buyer company']"));

    public static Target REGION_FIELD = Target.the("Region field")
            .located(By.xpath("//div[@placeholder='Select regions']//input[@class='el-select__input is-small']"));

    public static Target ADD_BUYER_COMPANY = Target.the("Button add new buyer company")
            .located(By.xpath("//div[@class='add-buyer-company-form mb-2 mt-2 tc']//button[@type='button']"));

    public static Target CASE_PRICE_FIELD = Target.the("CASE_PRICE_FIELD")
            .located(By.xpath("(//div[contains(@class,'store-case-price-cents')]//input[@type='number'])[last()]"));

    public static Target DYNAMIC_INPUT_BUYER_SPECIFIC(String buyer, String region, String input) {
        return Target.the("")
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td//div[contains(@class,'" + input + "')]//input"));
    }

    public static Target DYNAMIC_INPUT_BUYER_SPECIFIC2(String buyer, String region, String input) {
        return Target.the("")
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td//div[contains(@class,'" + input + "')]"));
    }
    public static Target OSS_CATEGORY_BUYER_SPECIFIC(String buyer, String region) {
        return Target.the("")
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td[6]"));
    }

    public static Target DYNAMIC_REMOVE_BUYER_SPECIFIC(String buyer, String region) {
        return Target.the("Remove" + region)
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td/button"));

    }

    public static Target DYNAMIC_ERROR_BUYER_SPECIFIC(String buyer, String region, String input) {
        return Target.the("")
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td//div[contains(@class,'" + input + "')]/ancestor::div[@class='el-form-item__content']//div[@class='el-form-item__error']"));

    }

    public static Target MSRP_UNIT_FIELD = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'msrp')]//input[@type='number'])[last()]"));

    public static Target AVAILABILITY = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'availability')]//input)[last()]"));

    public static Target ARRIVING = Target.the("")
            .located(By.xpath("(//div[contains(@class,'receiving')]//input)[last()]"));

    public static Target CATEGORY = Target.the("")
            .located(By.xpath("(//div[contains(@class,'out-of-stock')]//input)[last()]"));

    public static Target START_DATE = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'start-date')]//input)[last()]"));

    public static Target END_DATE = Target.the("MSRP_UNIT_FIELD")
            .located(By.xpath("(//div[contains(@class,'end-date')]//input)[last()]"));

    /**
     * Add multiple
     */


    public static Target MULYIPLE_BUYER_COMPANY_FIELD = Target.the("Buyer company Specific field")
            .located(By.xpath("//input[@placeholder='Select a buyer company']"));

    public static Target MULYIPLE_CHECK_ALL = Target.the("Buyer company Specific field")
            .located(By.xpath("//input[@id='multipleCheckAllStore']"));

    public static Target DYNAMIC_STORE_CHECK(String store) {
        return Target.the("")
                .located(By.xpath("//div[@class='stores-grid']//span[@data-original-text='" + store + "']"));

    }

    public static Target DYNAMIC_INPUT_STORE_SPECIFIC(String store, String input) {
        return Target.the("")
                .located(By.xpath("//span[text()='" + store + "']/parent::td/following-sibling::td//div[contains(@class,'" + input + "')]//input"));
    }
    public static Target DYNAMIC_INPUT_STORE_SPECIFIC2(String store, String input) {
        return Target.the("")
                .located(By.xpath("//span[text()='" + store + "']/parent::td/following-sibling::td//div[contains(@class,'" + input + "')]"));
    }


}

