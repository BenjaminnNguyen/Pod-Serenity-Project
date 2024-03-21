package cucumber.user_interface.admin.buyer;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class AllBuyerPage {

    /**
     * Buyer Result after search
     */
    public static Target BUYER_NAME = Target.the("Result name Company")
            .locatedBy("//td[contains(@class,'name')]//span");

    public static Target DYNAMIC_RESULT(String title) {
        return Target.the(title)
                .locatedBy("//td[contains(@class,'" + title + "')]//span");
    }

    public static Target WEBSITE = Target.the("Website of company")
            .locatedBy("//td[contains(@class,'website')]//span");

    public static Target STATUS = Target.the("Status of company")
            .locatedBy("//td[contains(@class,'status')]//div");

    public static Target STATUS_RESULT = Target.the("Status of company")
            .locatedBy("//div[contains(@class,'status-tag')]");

    public static Target BUYER_NAME_RESULT(String name) {
        return Target.the("Buyer name in result")
                .locatedBy("//td[contains(@class,'name')]//span[text()='" + name + "']");
    }

    public static Target BUYER_RESULT_DELETE_BUTTON(String buyer) {
        return Target.the("Buyer result delete button")
                .locatedBy("(//span[@data-original-text='" + buyer + "']/ancestor::td/following-sibling::td//button)[2]");
    }

    public static Target STORE_LINK = Target.the("Store link in result")
            .locatedBy("//td[contains(@class,'store')]//a");

    /**
     * Buyer Company Detail Page
     */
    public static Target DETAIL_EMAIL = Target.the("Email in detail page")
            .located(By.xpath("(//dt[text()='State']/following-sibling::dd//div)[1]"));

    public static Target DYNAMIC_DETAIL(String title) {
        return Target.the(title)
                .locatedBy("//*[@class='" + title + "']");
    }

    public static Target STORE_EDIT = Target.the("Email in detail page")
            .located(By.xpath("(//dt[text()='Store']/following-sibling::dd//div)[1]"));

    public static Target MANUAL_REGION_EDIT = Target.the("Manual region in detail page")
            .located(By.xpath("(//dt[text()='Manually added region']/following-sibling::dd/div)[1]"));

    public static Target BUYER_COMPANY_DETAIL = Target.the("Buyer company in detail")
            .located(By.xpath("//dt[text()='Buyer company']//following-sibling::dd//span"));

    public static Target STORE(String store) {
        return Target.the(store)
                .locatedBy("//span[text()='" + store + "']");
    }

    public static Target REGION_SELECT = Target.the("Region in detail page")
            .located(By.xpath("(//div[contains(@class,'region-select')])[1]"));

    public static Target APPROVE_BUTTON = Target.the("Button approve in detail page")
            .located(By.xpath("//button//span[text()='Approve']"));

    public static Target STORE_REDIRECT_LINK = Target.the("Store redirect link")
            .located(By.xpath("//dt[text()='Store']/following-sibling::dd//a"));

    /**
     * Create New Buyer Popup
     */

    public static Target CREATE_NEW_BUYER_BUTTON = Target.the("Create new buyer button")
            .located(By.xpath("//button//span[text()='Create']"));
    public static Target CREATE_NEW_BUYER_POPUP = Target.the("Create new buyer popup header")
            .located(By.xpath("//div[@role='dialog']//span[text()='Create new Buyer']"));

    public static Target CREATE_BUYER_FIRST_NAME_TEXTBOX = Target.the("First name textbox in create buyer")
            .located(By.xpath("(//label[text()='Name']/following-sibling::div//input)[1]"));

    public static Target CREATE_BUYER_LAST_NAME_TEXTBOX = Target.the("Last name textbox in create buyer")
            .located(By.xpath("(//label[text()='Name']/following-sibling::div//input)[2]"));

    public static Target CREATE_BUYER_EMAIL_TEXTBOX = Target.the("Email textbox in create buyer")
            .located(By.xpath("//label[text()='Email']/following-sibling::div//input"));

    public static Target CREATE_BUYER_ROLE_TEXTBOX = Target.the("Role textbox in create buyer")
            .located(By.xpath("//label[text()='Role']/following-sibling::div//input"));

    public static Target CREATE_BUYER_STORE_TEXTBOX = Target.the("Store textbox in create buyer")
            .located(By.xpath("//label[text()='Store']/following-sibling::div//input"));

    public static Target CREATE_BUYER_MANAGER_TEXTBOX = Target.the("Manager textbox in create buyer")
            .located(By.xpath("//label[text()='Manager']/following-sibling::div//input"));

    public static Target CREATE_BUYER_BUYER_COMPANY_TEXTBOX = Target.the("Buyer company textbox in create buyer")
            .located(By.xpath("//label[text()='Buyer company']/following-sibling::div//input"));

    public static Target CREATE_BUYER_REGION_TEXTBOX = Target.the("Regions textbox in create buyer")
            .located(By.xpath("//label[text()='Regions']/following-sibling::div//input"));

    public static Target CREATE_BUYER_DEPARTMENT_TEXTBOX = Target.the("Department textbox in create buyer")
            .located(By.xpath("//label[text()='Department']/following-sibling::div//input"));

    public static Target CREATE_BUYER_CONTACT_NUMBER_TEXTBOX = Target.the("Contact number textbox in create buyer")
            .located(By.xpath("//label[text()='Contact number']/following-sibling::div//input"));

    public static Target CREATE_BUYER_PASSWORD_TEXTBOX = Target.the("Password textbox in create buyer")
            .located(By.xpath("//label[text()='Password']/following-sibling::div//input"));

    public static Target CREATE_BUYER_TAG_TEXTBOX = Target.the("Tag textbox in create buyer")
            .located(By.xpath("//div[@role='dialog']//label[text()='Tags']/following-sibling::div//input"));

    public static Target CREATE_BUYER_BUTTON = Target.the("Create buyer button")
            .located(By.xpath("//div[@role='dialog']//button//span[text()='Create']"));

    public static Target CREATE_BUYER_EMAIL_ERROR = Target.the("Email error message in create buyer")
            .located(By.xpath("//label[text()='Email']/following-sibling::div//div[contains(@class,'error')]"));

    public static Target CREATE_BUYER_CONTACT_NUMBER_ERROR = Target.the("Contact number textbox in create buyer")
            .located(By.xpath("//label[text()='Contact number']/following-sibling::div//div[contains(@class,'error')]"));

    public static Target CREATE_BUYER_PASSWORD_ERROR = Target.the("Password textbox in create buyer")
            .located(By.xpath("//label[text()='Password']/following-sibling::div//div[contains(@class,'error')]"));

    public static Target REMOVE_REGION(String region) {
        return Target.the("Remove region of create head buyer")
                .located(By.xpath("//div[text()='" + region + "']/parent::div/following-sibling::div"));
    }

    /**
     * Create buyer - Tags
     */

    public static Target CREATE_BUYER_TAG_ADDED(String tag) {
        return Target.the("Create buyer tags added")
                .located(By.xpath("//div[@class='tag']//div[text()='" + tag + "']"));
    }

    public static Target CREATE_BUYER_TAG_ADDED_EXPIRY_DATE(String tag) {
        return Target.the("Create buyer tags added expiry date")
                .located(By.xpath("//div[@class='tag']//div[text()='" + tag + "']/parent::div/following-sibling::div/input"));
    }

    /**
     * Buyer detail - Tags
     */

    public static Target BUYER_DETAIL_TAGS(String tag) {
        return Target.the("Buyer detail tags " + tag)
                .located(By.xpath("//div[@class='tags']//span[text()='" + tag + "']"));
    }

    public static Target BUYER_DETAIL_TAGS_EXPIRY(String tag) {
        return Target.the("Buyer detail tags " + tag + " expiry")
                .located(By.xpath("//div[@class='tags']//span[text()='" + tag + "']/following-sibling::span/span"));
    }

    public static Target TAG_NOT_SET_IN_DETAIL = Target.the("Tag not set in detail")
            .located(By.xpath("//dt[text()='Company']/following-sibling::dd//div[@class='address-stamp']"));

    public static Target TAG_IN_DETAIL = Target.the("Tag in detail")
            .located(By.xpath("//div[@class='tags']//span"));

    /**
     * Buyer detail - Tags popup
     */

    public static Target TAGS_POPUP_LABEL = Target.the("Tag popup label")
            .located(By.xpath("//div[@role='tooltip']//label[text()='Tags']"));

    public static Target TAGS_TEXTBOX_POPUP = Target.the("Tag textbox in popup")
            .located(By.xpath("//div[@role='tooltip']//input[@placeholder='Select a tag']"));

    public static Target TAGS_DELETE_BUTTON_IN_POPUP(String tag) {
        return Target.the("Tag delete button in popup tags")
                .located(By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    public static Target TAGS_EXPIRY_TEXTBOX_IN_POPUP(String tag) {
        return Target.the("Tag expiry date textbox in popup tags")
                .located(By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/input"));
    }

    public static Target TAGS_UPDATE_BUTTON_POPUP = Target.the("Tag update button in popup")
            .located(By.xpath("//div[@role='tooltip' and @x-placement]//*[contains(text(),'Update')]"));

    /**
     * Buyer Detail Page
     */

    public static Target BUYER_DETAIL_MANAGER = Target.the("Buyer detail manager")
            .located(By.xpath("//span[@class='manager']//parent::div"));


    /**
     * Buyer Detail Page - Email setting
     */

    public static Target EMAIL_SETTING_ADMIN_CHECKED = Target.the("Email setting admin checked")
            .located(By.xpath("//div[text()='Admin']/parent::span/preceding-sibling::span[contains(@class,'is-checked')]"));

    public static Target EMAIL_SETTING_ORDER_CHECKED = Target.the("Email setting order checked")
            .located(By.xpath("//div[text()='Order']/parent::span/preceding-sibling::span[contains(@class,'is-checked')]"));

    /**
     * Footer link
     */

    public static Target FOOTER_LINK(String link) {
        return Target.the("Footer buyer order link")
                .located(org.openqa.selenium.By.xpath("//a[contains(text(),\"" + link + "\")]"));
    }

    /**
     * SKUs Allowlist
     */

    public static Target SKU_ALLOWLIST_DELETE(String sku) {
        return Target.the("Sku allowlist delete button")
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td[contains(@class,'actions')]/button");
    }
    //div[text()='AT SKU B Checkout1 c56']
}
