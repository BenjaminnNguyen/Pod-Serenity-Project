package cucumber.user_interface.admin.vendors;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllVendorsForm {

    public static Target CREATE_NEW_VENDOR_FIELD_LABEL = Target.the("Create new vendor field label")
            .located(By.xpath("//div[@role='dialog']//span[contains(@class,'title')]"));

    /**
     * Create new Vendor field - Popup
     */

    public static Target NAME_CUSTOM_VENDOR_FIELD_TEXTBOX = Target.the("Create new vendor field name textbox")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'name')]/input"));

    public static Target DATA_TYPE_CUSTOM_VENDOR_FIELD_TEXTBOX = Target.the("Create new vendor field data type textbox")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'suffix')]/input"));

    public static Target NAME_CUSTOM_VENDOR_FIELD_ERROR = Target.the("Create new vendor field name error message")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'name')]/following-sibling::div[contains(@class,'error')]"));

    public static Target DATA_TYPE_CUSTOM_VENDOR_FIELD_ERROR = Target.the("Create new vendor field data type error message")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'suffix')]/following-sibling::div[contains(@class,'error')]"));

    public static Target PASWORD_FIELD_ERROR = Target.the("Create new vendor field pasword error message")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'password')]/following-sibling::div[contains(@class,'error')]"));


    /**
     * Create new Vendor
     */

    public static Target CREATE_VENDOR_BUTTON = Target.the("Create new vendor button")
            .located(By.xpath("//div[@class='page-header']//button//span[text()='Create']"));

    public static Target D_CREATE_VENDOR_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("(//label[text()='" + title + "']/following-sibling::div//input)[1]"));
    }

    public static Target LAST_NAME_TEXTBOX = Target.the("Last name textbox")
            .located(By.xpath("(//label[text()='Name']/following-sibling::div//input)[2]"));

    public static Target D_CREATE_VENDOR_ERROR(String title) {
        return Target.the(title + " message")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div/div[contains(@class,'error')]"));
    }

    public static Target TAG_CREATE_VENDOR(String tag) {
        return Target.the("Tag after added in create vendor popup")
                .located(By.xpath("//div[@class='tag']//div[contains(@class,'tooltip') and text()='" + tag + "']"));
    }

    public static Target TAG_CREATE_VENDOR_DELETE_BUTTON(String tag) {
        return Target.the("Tag after delete button in create vendor popup")
                .located(By.xpath("//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    /**
     * Vendor result search
     */

    public static Target NAME_IN_RESULT = Target.the("Name in result")
            .located(By.xpath("//td[contains(@class,'name')]//span"));

    public static Target NAME_IN_RESULT(String vendor) {
        return Target.the("Name in result")
                .located(By.xpath("//td[contains(@class,'name')]//span[@data-original-text='" + vendor + "']"));
    }

    public static Target EMAIL_IN_RESULT = Target.the("Email in result")
            .located(By.xpath("//td[contains(@class,'email')]//span"));

    public static Target VENDOR_COMPANY_IN_RESULT = Target.the("Vendor company in result")
            .located(By.xpath("//td[contains(@class,'company')]//span"));

    public static Target ADDRESS_IN_RESULT = Target.the("Address in result")
            .located(By.xpath("(//td[contains(@class,'address')]//span)[1]"));

    public static Target SHOPIFY_IN_RESULT = Target.the("Shopify in result")
            .located(By.xpath("(//td[contains(@class,'address')]//span)[2]"));

    public static Target DELETE_RESULT_BUTTON(String name) {
        return Target.the("Delete result button")
                .located(By.xpath("(//span[@data-original-text='" + name + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button)[2]"));
    }

    /**
     * Vendor detail
     */
    public static Target GENERAL_INFO_LABEL = Target.the("General info label")
            .located(By.xpath("//div[text()='General information']"));

    public static Target EMAIL_IN_DETAIL = Target.the("Name in detail")
            .located(By.xpath("//dt[text()='Email']/following-sibling::dd//span[@class='email']"));

    public static Target FIRST_NAME_IN_DETAIL = Target.the("First name in detail")
            .located(By.xpath("//dt[text()='First name']/following-sibling::dd//span[@class='first-name']"));

    public static Target LAST_NAME_IN_DETAIL = Target.the("Last name in detail")
            .located(By.xpath("//dt[text()='Last name']/following-sibling::dd//span[@class='last-name']"));

    public static Target COMPANY_IN_DETAIL = Target.the("Company in detail")
            .located(By.xpath("//dt[text()='Company']/following-sibling::dd//span[@class='company']"));

    public static Target ADDRESS_IN_DETAIL = Target.the("Address in detail")
            .located(By.xpath("//dt[text()='Company']/following-sibling::dd//div[@class='address-stamp']"));

    public static Target TAGS_IN_DETAIL(String tag) {
        return Target.the("Tag in detail")
                .located(By.xpath("//div[@class='tags']//span[text()='" + tag + "']"));
    }

    public static Target TAGS_EXPIRY_DATE_IN_DETAIL(String tag) {
        return Target.the("Tag expiry date in detail")
                .located(By.xpath("//div[@class='tags']//span[text()='" + tag + "']/following-sibling::span/span"));
    }

    public static Target TAG_NOT_SET_IN_DETAIL = Target.the("Tag not set in detail")
            .located(By.xpath("//dt[text()='Company']/following-sibling::dd//div[@class='address-stamp']"));

    public static Target TAG_IN_DETAIL = Target.the("Tag in detail")
            .located(By.xpath("//div[@class='tags']//span"));

    /**
     * Tags popup in vendor detail
     */

    public static Target TAGS_POPUP_LABEL = Target.the("Tag popup label")
            .located(By.xpath("//div[@role='tooltip']//label[text()='Tags']"));

    public static Target TAGS_TEXTBOX_POPUP = Target.the("Tag textbox in popup")
            .located(By.xpath("//div[@role='tooltip']//input[@placeholder='Select a tag']"));

    public static Target TAGS_IN_POPUP(String tag) {
        return Target.the("Tag in popup tags")
                .located(By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']"));
    }

    public static Target TAGS_EXPIRY_TEXTBOX_IN_POPUP(String tag) {
        return Target.the("Tag expiry date textbox in popup tags")
                .located(By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/input"));
    }

    public static Target TAGS_DELETE_BUTTON_IN_POPUP(String tag) {
        return Target.the("Tag delete button in popup tags")
                .located(By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    public static Target TAGS_UPDATE_BUTTON_POPUP = Target.the("Tag update button in popup")
            .located(By.xpath("//div[@role='tooltip' and @x-placement]//button[contains(text(),'Update')]"));

    /**
     * Vendor detail - Custom field
     */

    public static Target CUSTOM_FIELD_DETAIL(String title, String value) {
        return Target.the("Custom field in vendor detail")
                .located(By.xpath(" //dt[contains(text(),'" + title + "')]/following-sibling::dd//span[@class='" + value + "']"));
    }

    public static Target CUSTOM_FIELD_DETAIL_FILE = Target.the("Custom field file")
            .located(By.xpath("(//dt[contains(text(),'Vendor file')]//following-sibling::dd//div[@class='choose ellipsis'])[1]"));

    public static Target CUSTOM_FIELD_FILE_REMOVE_BUTTON = Target.the("Custom field file in vendor company remove button")
            .located(By.xpath("(//dt[contains(text(),'Vendor file')]//following-sibling::dd//button)[1]"));

    public static Target CUSTOM_FIELD_FILE_UPLOAD = Target.the("Custom field file in vendor company upload button")
            .located(By.xpath("(//dt[contains(text(),'Vendor file')]//following-sibling::dd//input)[1]"));

    public static Target CUSTOM_FIELD_FILE_SAVE_BUTTON= Target.the("Custom field file in vendor company save button")
            .located(By.xpath("//dt[contains(text(),'Vendor file')]//following-sibling::dd//button//span[text()='Save']"));

    /**
     * Footer link
     */

    public static Target FOOTER_PRODUCT_LINK= Target.the("Footer product link")
            .located(By.xpath("//a[text()='Find all products by this vendor']"));
}

