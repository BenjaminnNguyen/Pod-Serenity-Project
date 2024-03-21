package cucumber.user_interface.admin.vendors;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class SuccessFormPage {

    /**
     * Store list
     */

    public static Target RESULT_ID(String buyerCompany) {
        return Target.the("ID of " + buyerCompany + " of result search in popup")
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/preceding-sibling::td[contains(@class,'id')]//a"));
    }

    public static Target RESULT_BUYER_COMPANY(String buyerCompany) {
        return Target.the("Result buyer company " + buyerCompany)
                .located(By.xpath("//td[contains(@class,'buyer-company')]//span[text()='" + buyerCompany + "']"));
    }

    public static Target RESULT_VENDOR_COMPANY(String buyerCompany) {
        return Target.the("Result vendor company " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/preceding-sibling::td[contains(@class,'vendor-company')]//span"));
    }

    public static Target RESULT_VENDOR_NAME(String buyerCompany) {
        return Target.the("Result vendor name " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/preceding-sibling::td[contains(@class,'vendor-name')]//span"));
    }

    public static Target RESULT_SUBMITTED_DATE(String buyerCompany) {
        return Target.the("Result submitted date " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/preceding-sibling::td[contains(@class,'vendor-name')]//span"));
    }

    public static Target RESULT_REGION(String buyerCompany) {
        return Target.the("Result region " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'region')]//div"));
    }

    public static Target RESULT_STORE_TYPE(String buyerCompany) {
        return Target.the("Result store type " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'store-type')]//div"));
    }

    public static Target RESULT_KEY_ACCOUNT(String buyerCompany) {
        return Target.the("Result key account " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'key-account')]//div"));
    }

    public static Target RESULT_CURRENT_STORE(String buyerCompany) {
        return Target.the("Result current store " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'current-store')]//div[@class='status-tag']"));
    }

    public static Target RESULT_DISTRIBUTION_TYPE(String buyerCompany) {
        return Target.the("Result distribution type " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'distribution-type')]//span"));
    }

    public static Target RESULT_CONTACTED(String buyerCompany) {
        return Target.the("Result contacted " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'contacted')]//span/span"));
    }

    public static Target RESULT_SAMPLE_SENT(String buyerCompany) {
        return Target.the("Result sample sent " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'sample-sent')]//span/span"));
    }

    public static Target RESULT_STATUS(String buyerCompany) {
        return Target.the("Result status " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'status')]//div[@class='status']"));
    }

    public static Target RESULT_NOTES(String buyerCompany) {
        return Target.the("Result note " + buyerCompany)
                .located(By.xpath("//span[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'note')]//span"));
    }

    /**
     * Create new form
     */
    public static Target CREATE_NEW_FORM_BUTTON = Target.the("Create new form button")
            .located(By.xpath("//button//span[text()='Create new form']"));

    public static Target CREATE_NEW_SUCCESS_POPUP = Target.the("Create new success popup")
            .located(By.xpath("//div[@id='global-dialogs']//span[text()='Create new success form']"));

    public static Target CREATE_NEW_ENTITY_POPUP = Target.the("Create new entity popup")
            .located(By.xpath("//div[@id='global-dialogs']//span[text()='Create new Entity']"));
    public static Target SELECT_VENDOR_TEXTBOX = Target.the("Select vendor textbox")
            .located(By.xpath("//div[@id='global-dialogs']//div[contains(@class,'vendor-company-select')]//input"));

    /**
     * Create new form - search
     */
    public static Target BUYER_COMPANY_TEXTBOX = Target.the("Buyer company textbox")
            .located(By.xpath("//div[contains(@class,'vendor-company-select')]//input"));

    public static Target SEARCH_D_TEXTBOX(String title) {
        return Target.the("Search " + title + " textbox")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input"));
    }

    public static Target CREATE_POPUP_SEARCH_BUTTON = Target.the("Create new form search button")
            .located(By.xpath("//div[@id='global-dialogs']//button[contains(@class,'search')]"));

    public static Target CREATE_POPUP_RESET_BUTTON = Target.the("Create new form reset button")
            .located(By.xpath("//div[@id='global-dialogs']//button[contains(@class,'reset')]"));

    /**
     * Create new form - result search
     */

    public static Target RESULT_BUYER_COMPANY_IN_POPUP(String buyerCompany) {
        return Target.the("Buyer company " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]"));
    }

    public static Target RESULT_REGION_IN_POPUP(String buyerCompany) {
        return Target.the("Region " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/following-sibling::span"));
    }

    public static Target RESULT_STORE_TYPE_IN_POPUP(String buyerCompany) {
        return Target.the("Store type " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'store-type')]"));
    }

    public static Target RESULT_KEY_ACCOUNT_IN_POPUP(String buyerCompany) {
        return Target.the("Key account " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'key-account')]//span/span"));
    }

    public static Target RESULT_CURRENT_STORE_IN_POPUP(String buyerCompany) {
        return Target.the("Current store " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'current-store')]//input"));
    }

    public static Target RESULT_DISTRIBUTION_IN_POPUP(String buyerCompany) {
        return Target.the("Distribution " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'distribution')]//input"));
    }

    public static Target RESULT_CONTACTED_IN_POPUP(String buyerCompany) {
        return Target.the("Contacted " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'contacted')]//input"));
    }

    public static Target RESULT_SAMPLE_SENT_IN_POPUP(String buyerCompany) {
        return Target.the("Sample sent " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'sample-sent')]//input"));
    }

    public static Target RESULT_STATUS_IN_POPUP(String buyerCompany) {
        return Target.the("Status " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'note')]//textarea"));
    }

    public static Target RESULT_NOTE_IN_POPUP(String buyerCompany) {
        return Target.the("Notes " + buyerCompany + " of result search in popup")
                .located(By.xpath("//div[contains(text(),'" + buyerCompany + "')]/ancestor::td/following-sibling::td[contains(@class,'note')]//textarea"));
    }

    /**
     * Edit form
     */
    public static Target D_EDIT_TEXTBOX(String title) {
        return Target.the("Textbox " + title + "in popup edit")
                .located(By.xpath("//div[@role='dialog']//label[text()='" + title + "']/following-sibling::div//input"));
    }

    public static Target D_EDIT_TEXTAREA(String title) {
        return Target.the("Textarea " + title + "in popup edit")
                .located(By.xpath("//div[@role='dialog']//label[text()='" + title + "']/following-sibling::div//textarea"));
    }

    public static Target EDIT_POPUP_SHOW_VENDOR_CHECKBOX = Target.the("Show on vendor dashboard in edit popup")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'show-admin-note')]"));

    /**
     * Mass Editing - Search
     */

    public static Target MASS_EDITING_BUTTON = Target.the("Mass editing button")
            .located(By.xpath("//button//span[text()='Mass editing']"));

    public static Target MASS_EDITING_POPUP = Target.the("Mass editing popup")
            .located(By.xpath("//div[@id='global-dialogs']//span[text()='Create new Entity']"));

    public static Target D_MASS_EDIT_TEXTBOX(String title) {
        return Target.the("Textbox " + title + " in mass editing popup")
                .located(By.xpath("//div[@id='global-dialogs']//label[contains(text(),'" + title + "')]//following-sibling::div//input"));
    }

    /**
     * Mass Editing - Edit
     */

    public static Target D_MASS_EDIT_BODY_TEXTBOX(String title) {
        return Target.the("Textbox " + title + " in mass editing popup")
                .located(By.xpath("//div[@id='global-dialogs']//div[contains(@class,'row')]//label[contains(text(),'" + title + "')]//following-sibling::div//input"));
    }

    public static Target D_MASS_EDIT_BODY_TEXTAREA(String title) {
        return Target.the("Textarea " + title + "in popup edit")
                .located(By.xpath("//div[@role='dialog']//label[text()='" + title + "']/following-sibling::div//textarea"));
    }

    /**
     * Mass Editing - Result
     */


    public static Target MASS_CHECKBOX(String buyerCompany) {
        return Target.the("Checkbox of buyer company " + buyerCompany + "in mass editing")
                .located(By.xpath("//div[text()='" + buyerCompany + "']/ancestor::td/preceding-sibling::td//label"));
    }

    public static Target MASS_BUYER_COMPANY(String buyerCompany) {
        return Target.the("Buyer company in mass editing")
                .located(By.xpath("//div[@id='global-dialogs']//td[contains(@class,'store-name')]//div[text()='" + buyerCompany + "']"));
    }

    public static Target MASS_REGION(String buyerCompany) {
        return Target.the("Region in mass editing")
                .located(By.xpath("//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'region')]/div"));
    }

    public static Target MASS_STORE_TYPE(String buyerCompany) {
        return Target.the("Region in mass editing")
                .located(By.xpath("//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'store-type')]/div"));
    }

    public static Target MASS_CURRENT_STORE(String buyerCompany) {
        return Target.the("Current store in mass editing")
                .located(By.xpath("//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'current-store')]/div/div"));
    }

    public static Target MASS_DISTRIBUTION_TYPE(String buyerCompany) {
        return Target.the("Distribution type in mass editing")
                .located(By.xpath("//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'distribution')]//span"));
    }

    /**
     * Add Special Buyer Company - Search
     */

    public static Target ADD_SPECIAL_POPUP = Target.the("Add special popup")
            .located(By.xpath("//div[@id='global-dialogs']//span[text()='Create new Entity']"));

    public static Target ADD_SPECIAL_BUYER_COMPANY_TEXTBOX = Target.the("Textbox select buyer company in add special buyer company popup")
            .located(By.xpath("//div[@id='global-dialogs']//div[contains(@class,'buyer-company')]//input"));

    public static Target ADD_SPECIAL_REGION_TEXTBOX = Target.the("Textbox select region in add special buyer company popup")
            .located(By.xpath("//div[@id='global-dialogs']//div[contains(@class,'region')]//input"));

    public static Target ADD_BUYER_COMPANY_BUTTON = Target.the("Add buyer company button")
            .located(By.xpath("//div[@id='global-dialogs']//div[contains(@class,'region')]//input"));

    /**
     * Add Special Buyer Company - Result added
     */

    public static Target ADD_SPECIAL_RESULT_BUYER_COMPANY(String buyerCompany) {
        return Target.the("Add special buyer company result")
                .located(By.xpath("//div[@id='global-dialogs']//td[contains(@class,'store-name')]//div[text()='" + buyerCompany + "']"));
    }

    public static Target ADD_SPECIAL_RESULT_REGION(String buyerCompany) {
        return Target.the("Add special buyer company region result")
                .located(By.xpath("//div[@role='dialog']//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'region')]//span"));
    }

    public static Target ADD_SPECIAL_RESULT_STORE_TYPE(String buyerCompany) {
        return Target.the("Add special buyer company store type result")
                .located(By.xpath("//div[@role='dialog']//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'store-type')]//div"));
    }

    public static Target ADD_SPECIAL_RESULT_DATE(String buyerCompany) {
        return Target.the("Add special buyer company store type result")
                .located(By.xpath("//div[@role='dialog']//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'date')]//div[@class='date']"));
    }

    public static Target ADD_SPECIAL_RESULT_MANAGED_BY(String buyerCompany) {
        return Target.the("Add special buyer company managed by result")
                .located(By.xpath("//div[@role='dialog']//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'manage-by')]//div"));
    }

    public static Target ADD_SPECIAL_RESULT_DELETE_BUTTON(String buyerCompany) {
        return Target.the("Add special buyer company delete button by result")
                .located(By.xpath("//div[@role='dialog']//div[text()='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button/span"));
    }

}