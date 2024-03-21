package cucumber.user_interface.admin.financial;

import net.serenitybdd.screenplay.targets.Target;

public class VendorStatementsDetailPage {

    public static Target ORDER_DETAIL(String order, String value) {
        return Target.the(value).locatedBy("//span[normalize-space()='" + order + "']/ancestor::tr[@class='item']//span[contains(@class,'" + value + "')]");
    }

    public static Target DESCRIPION_DETAIL(String order, String value) {
        return Target.the(value).locatedBy("//span[normalize-space()='" + order + "']/ancestor::tr[@class='item']//div[contains(@class,'" + value + "')]/span");
    }

    /**
     * Vendor statements popup
     */

    public static Target D_ERROR_ADJUSTMENT_POPUP(String title) {
        return Target.the("Error textbox")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//div[contains(@class,'error')]");
    }


    public static Target CLOSE_ADJUSTMENT_POPUP = Target.the("Add an adjustment close popup")
            .locatedBy("//div[@role='dialog']//span[text()='Add an adjustment']/parent::div/following-sibling::button");

    public static Target ADD_AN_ADJUSTMENT_LABEL = Target.the("Add an adjustment label")
            .locatedBy("//div[@role='dialog']//span[text()='Add an adjustment']");

    public static Target EDIT_AN_ADJUSTMENT_LABEL = Target.the("Edit an adjustment label")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Edit')]");

    public static Target VALUE_TEXTBOX_ADJUSTMENT_POPUP = Target.the("Value textbox in adjustment popup")
            .locatedBy("//label[text()='Value']//following-sibling::div//input");

    public static Target TYPE_TEXTBOX_ADJUSTMENT_POPUP = Target.the("Type textbox in adjustment popup")
            .locatedBy("//label[text()='Type']//following-sibling::div//input");

    public static Target EFFECTIVE_DATE_TEXTBOX_ADJUSTMENT_POPUP = Target.the("Effective date textbox in adjustment popup")
            .locatedBy("//label[text()='Effective date']//following-sibling::div//input");

    public static Target ICON_CLOSE_TEXTBOX_ADJUSTMENT_POPUP = Target.the("Effective date icon close in adjustment popup")
            .locatedBy("//label[text()='Effective date']//following-sibling::div//i[contains(@class,'close')]");

    public static Target DESCRIPTION_TEXTBOX_ADJUSTMENT_POPUP = Target.the("Description textbox in adjustment popup")
            .locatedBy("//div[@id='global-dialogs']//label[text()='Description']//following-sibling::div//input");

    public static Target EDIT_ADJUSTMENT_BUTTON(String description) {
        return Target.the("Edit adjustment button")
                .locatedBy("(//span[contains(text(),'" + description + "')]/ancestor::td/preceding-sibling::td[@class='actions']//button)[1]");
    }

    public static Target DELETE_ADJUSTMENT_BUTTON(String description) {
        return Target.the("Delete adjustment button")
                .locatedBy("(//span[contains(text(),'" + description + "')]/ancestor::td/preceding-sibling::td[@class='actions']//button)[2]");
    }

    public static Target ALERT_MESSAGE_ADJUSTMENT(String message) {
        return Target.the("Alert message when delete adjustment")
                .locatedBy("//p[contains(text(),\"" + message + "\")]");
    }

    /**
     * Automatic Payment Process
     */

    public static Target AUTO_PAYMENT_PROCESS_POPUP = Target.the("Automatic Payment Process dialog")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Automatic Payment Process']");

    public static Target FILTER_AMOUNT_PROCESS_POPUP = Target.the("Filter amount process popup")
            .locatedBy("(//label[text()='Filter by Amount']/following-sibling::div//input)[1]");

    public static Target AMOUNT_PROCESS_POPUP = Target.the("Amount process popup")
            .locatedBy("(//label[text()='Filter by Amount']/following-sibling::div//input)[2]");

    public static Target VENDOR_COMPANY_PROCESS_POPUP = Target.the("Reviewing vendor company in process popup")
            .locatedBy("//div[text()='Reviewing']/following-sibling::div//input");


    public static Target PROCESS_TEXTBOX_POPUP(String title) {
        return Target.the("Automatic Payment Process dialog")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target SELECT_ALL_CHECKBOX = Target.the("Select all checkbox")
            .locatedBy("//thead//label[contains(@class,'el-checkbox')]");

    public static Target VENDOR_COMPANY_CHECKBOX_PROCESS_POPUP(String vendorCompany) {
        return Target.the("vendor company process popup")
                .locatedBy("//div[@role='dialog']//tbody//a[text()='" + vendorCompany + "']/parent::td/preceding-sibling::td/label[contains(@class,'el-checkbox')]");
    }

}
