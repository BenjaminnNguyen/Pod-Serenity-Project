package cucumber.user_interface.beta.Vendor.storeList;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorStoreListPage {

    public static Target DYNAMIC_TAB(String tabName) {
        return Target.the("Tab " + tabName)
                .locatedBy("//div[contains(@class,'entity-header')]//*[text()='" + tabName + "']");
    }

    /**
     * Search store list textbox
     */

    public static Target D_SEARCH_TEXTBOX(String title) {
        return Target.the("Textbox search " + title)
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    /**
     * List store list
     */


    public static Target RESULT_BUYER_COMPANY(String buyerCompany) {
        return Target.the("Result buyer company " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]");
    }

    public static Target RESULT_STORE_TYPE(String buyerCompany) {
        return Target.the("Result store type " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'store-type')]/div/span");
    }

    public static Target RESULT_REGION(String buyerCompany) {
        return Target.the("Result store type " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div[@class='name']/following-sibling::div[contains(@class,'region')]");
    }

    public static Target RESULT_KEY_ACCOUNT(String buyerCompany) {
        return Target.the("Result key account " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'key-account')]/div/span");
    }

    public static Target RESULT_CURRENT_STORE(String buyerCompany) {
        return Target.the("Result current store " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'current-store')]//input");
    }

    public static Target RESULT_DISTRIBUTION_TYPE(String buyerCompany) {
        return Target.the("Result distribution type " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'distribution-type')]//input");
    }

    public static Target RESULT_CONTACTED(String buyerCompany) {
        return Target.the("Result contacted " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'contacted')]//input");
    }

    public static Target RESULT_SAMPLE_SENT(String buyerCompany) {
        return Target.the("Result sample sent " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'samples-sent')]//input");
    }

    public static Target RESULT_NOTE(String buyerCompany) {
        return Target.the("Result note " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'notes')]//textarea");
    }

    public static Target RESULT_POD_FOODS_NOTES(String buyerCompany) {
        return Target.the("Result pod foods notes " + buyerCompany)
                .locatedBy("//div[@class='content']//span[contains(text(),'" + buyerCompany + "')]/ancestor::div/following-sibling::div[contains(@class,'admin-notes')]//span");
    }

    public static Target LINK_BCN(String buyerCompany) {
        return Target.the("Link to buyer company " + buyerCompany)
                .locatedBy("//div[@class='stores-list']//div[@class='name']//span[contains(text(),'" + buyerCompany + "')]/parent::a");
    }

    public static Target CHECKBOX_STORE(String buyerCompany) {
        return Target.the("Link to buyer company " + buyerCompany)
                .locatedBy("//span[contains(text(),'" + buyerCompany + "')]/ancestor::div[@class='edt-row record']/div[1]//label[contains(@class,'el-checkbox large')]");
    }

    public static Target MASS_EDIT_ALL = Target.the("")
            .located(By.xpath("//div[@class='stores-list']/div[1]//label[contains(@class,'el-checkbox large')]"));
    public static Target RESULT_POD_FOODS_NOTES = Target.the("Warning message").locatedBy("//div[@class='warning__message']");
}
