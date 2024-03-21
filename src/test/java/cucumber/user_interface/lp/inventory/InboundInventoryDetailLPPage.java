package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class InboundInventoryDetailLPPage {

    public static Target GENERAL_INFORMATION_LABEL = Target.the("General information label")
            .locatedBy("//div[text()='General Information']");

    public static Target DYNAMIC_GENERAL_INFORMATION(String field) {
        return Target.the("General information ")
                .located(By.xpath("(//*[normalize-space()='" + field + "']/following-sibling::dd)[1]"));
    }


    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target VENDOR_COMPANY = Target.the("The vendor company")
            .located(By.xpath("//dt[normalize-space()='Vendor Company']/following-sibling::dd"));

    public static Target STATUS = Target.the("The status")
            .located(By.xpath("//dt[normalize-space()='Status']/following-sibling::dd"));

    public static Target ETA = Target.the("The Estimated Date of Arrival")
            .located(By.cssSelector("span.eta"));

    // SKU
    public static Target ITEM(String lot, String class_) {
        return Target.the("").locatedBy("//a[contains(@title,'" + lot + "')]/ancestor::div[@class='edt-row']//div[@class='" + class_ + "']");
    }

    public static Target CASE_UPC(String lot) {
        return Target.the("").locatedBy("//a[contains(@title,'" + lot + "')]/ancestor::div[@class='edt-row']//div[@class='upc'][2]");
    }

    public static Target ITEM_CASES(String lot, String field) {
        return Target.the("").locatedBy("//a[contains(@title,'" + lot + "')]/ancestor::div[@class='flex fdc inbound-items']//label[text()='" + field + "']/following-sibling::div//input");
    }

    public static Target UPLOAD_SIGNED_WPL = Target.the("Upload file signed WPL button")
            .located(By.xpath("//input[@type='file']"));
    /**
     * Create new inventory
     */
    public static Target CREATE_NEW_INVENTORY_HEADER = Target.the("Create new inventory header")
            .located(By.xpath("//h1[text()='Create new Inventory']"));

    public static Target NEW_INVENTORY_BUTTON = Target.the("New inventory button")
            .located(By.xpath("//button//span[text()='New Inventory']"));

    public static Target D_TEXTBOX_CREATENEW(String title) {
        return Target.the("Textbox " + title + " of create new inventory")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target D_LINK(String value) {
        return Target.the("Link " + value)
                .locatedBy("//a[text()='" + value + "']");
    }

    public static Target APPOINTMENT_DATE = Target.the("APPOINTMENT_DATE")
            .locatedBy("//input[@placeholder='Select date']");

    public static Target APPOINTMENT_TIME = Target.the("APPOINTMENT_TIME")
            .locatedBy("//input[@placeholder='Select time']");

    public static Target CLEAR_ICON = Target.the("CLEAR_ICON")
            .locatedBy("//i[@class='el-input__icon el-icon-circle-close']");


    public static Target APPOINTMENT_TIME(String time) {
        return Target.the("APPOINTMENT_TIME")
                .locatedBy("//div[normalize-space()='" + time + "']");
    }

    /**
     * Inbound Inventory Images (You can upload up to 10 images)
     */
    public static Target INBOUND_INVENTORY_IMAGE(String description) {
        return Target.the("Inbound Inventory Images")
                .locatedBy("//div[contains(@class,'inventory-image-card')]//div[text()='" + description + "']");
    }

    public static Target INBOUND_INVENTORY_IMAGE_PREVIEW(String description) {
        return Target.the("Inbound Inventory Images preview")
                .locatedBy("(//div[text()='" + description + "']/parent::div/following-sibling::div/button)[1]");
    }

    public static Target INBOUND_INVENTORY_IMAGE_DELETE(String description) {
        return Target.the("Inbound Inventory Images delete")
                .locatedBy("(//div[text()='" + description + "']/parent::div/following-sibling::div/button)[2]");
    }

    public static Target REMOVE_IMAGE_BUTTON(String index) {
        return Target.the("Remove image button " + index)
                .located(By.xpath("(//div[contains(@class,'inventory-image-card')])[" + index + "]//button"));
    }

    public static Target IMAGE_INDEX(String index) {
        return Target.the("Image index " + index)
                .located(By.xpath(" (//div[contains(@class,'inventory-image-card')])[" + index + "]//div[@class='image-container']//input"));
    }

    public static Target DESCRIPTION_TEXTBOX(String index) {
        return Target.the("Description textbox " + index)
                .located(By.xpath("(//div[contains(@class,'inventory-image-card')])[" + index + "]//div[@class='image-container']/following-sibling::div/input"));
    }

    public static Target UPDATE_IMAGES = Target.the("Button update inbound inventory image")
                .located(By.xpath("//div[contains(text(),'Inbound Inventory Images')]/following-sibling::div//button/span[text()='Update']"));

    public static Target REMOVE_BUTTON = Target.the("Button remove inbound inventory image")
            .located(By.xpath("//i[contains(@class,'trash')]//parent::span"));


}
