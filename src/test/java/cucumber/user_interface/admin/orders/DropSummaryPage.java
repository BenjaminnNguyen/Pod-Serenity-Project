package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class DropSummaryPage {

    /**
     * Sub-invoices result
     */

    public static Target ORDER_RESULT_SUB(String subInvoice) {
        return Target.the("Order in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[@class='order']/a");
    }

    public static Target CHECK_RESULT_SUB(String subInvoice) {
        return Target.the("Checkbox in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[@class='check']/label");
    }

    public static Target REGION_RESULT_SUB(String subInvoice) {
        return Target.the("Region in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[@class='region']/span");
    }

    public static Target STORE_RESULT_SUB(String subInvoice) {
        return Target.the("Store in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[@class='store']");
    }

    public static Target SUB_INVOICE_RESULT_SUB(String subInvoice) {
        return Target.the("Sub-invoice in result")
                .locatedBy("//td[@class='sub-invoice']//div[text()='" + subInvoice + "']");
    }

    public static Target SOS_RESULT_SUB(String subInvoice) {
        return Target.the("SOS in result")
                .locatedBy("(//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[@class='small-order-surcharge']//span)[last()]");
    }

    public static Target FUEL_RESULT_SUB(String subInvoice) {
        return Target.the("Fuel surcharge in result")
                .locatedBy("(//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'logistics-surcharge-cents')]//span)[last()]");
    }

    public static Target TOTAL_PAYMENT_RESULT_SUB(String subInvoice) {
        return Target.the("Total payment in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-payment')]");
    }

    public static Target TOTAL_ORDERED_RESULT_SUB(String subInvoice) {
        return Target.the("Total ordered in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-ordered')]");
    }

    public static Target VENDOR_FEE_RESULT_SUB(String subInvoice) {
        return Target.the("Vendor fee in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'vendor-fee')]");
    }

    public static Target TOTAL_WEIGHT_RESULT_SUB(String subInvoice) {
        return Target.the("Total weight in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-weight')]");
    }

    public static Target ETA_RESULT_SUB(String subInvoice) {
        return Target.the("ETA in result")
                .locatedBy("//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'eta')]/span");
    }

    /**
     * Popup Create Drop
     */

    public static Target VALUE_IN_CREATE_ACTION_BAR(String title) {
        return Target.the(title + " in create drop action bar")
                .locatedBy("//span[contains(text(),'" + title + "')]/strong");
    }

    public static Target CLEAR_ACTION_IN_ACTION_BAR = Target.the("Action clear selected in create drop action bar")
            .locatedBy("//div[@class='drop-summary-action-bar']//span[text()='Clear selection']");

    public static Target CREATE_DROP_POPUP = Target.the("Action clear selected in create drop popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Create drops']");

    public static Target REGION_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Region in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/preceding-sibling::td/span");
    }

    public static Target SUB_INVOICE_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Sub invoice in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//td[@class='sub-invoice']/div[text()='" + subinvoice + "']");
    }

    public static Target STORE_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Store in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/preceding-sibling::td[@class='store']");
    }

    public static Target ORDER_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Order in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/preceding-sibling::td[@class='order']/a");
    }

    public static Target SOS_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("SOS in create drop popup")
                .locatedBy("(//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'small-order-surcharge')]//span)[last()]");
    }

    public static Target SOS_IN_CREATE_DROP_POPUP1(String subinvoice) {
        return Target.the("SOS in create drop popup not visible")
                .locatedBy("(//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'small-order-surcharge')]//div)[last()]");
    }

    public static Target FUEL_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Fuel in create drop popup")
                .locatedBy("(//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'logistics-surcharge')]//span)[last()]");
    }

    public static Target TOTAL_PAYMENT_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Total payment in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'total-payment')]");
    }

    public static Target TOTAL_ORDERED_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Total ordered in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'total-ordered-amount')]");
    }

    public static Target VENDOR_FEE_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Vendor fee in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'vendor-fee')]");
    }

    public static Target TOTAL_WEIGHT_IN_CREATE_DROP_POPUP(String subinvoice) {
        return Target.the("Total weight in create drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subinvoice + "']/parent::td/following-sibling::td[contains(@class,'total-weight')]");
    }

    public static Target TOTAL_PAYMENT_SUMMARY_IN_POPUP(String store) {
        return Target.the("Total payment in summary of store " + store + " create drop popup")
                .locatedBy("(//span[text()='" + store + "']/ancestor::div/following-sibling::div//dt[text()='Total payment']/following-sibling::dd[@class='total-payment'])[1]");
    }

    public static Target TOTAL_ORDERED_SUMMARY_IN_POPUP(String store) {
        return Target.the("Total ordered amount in summary of store " + store + " create drop popup")
                .locatedBy("(//span[text()='" + store + "']/ancestor::div/following-sibling::div//dt[text()='Total payment']/following-sibling::dd[@class='total-payment'])[2]");
    }

    public static Target VENDOR_FEE_SUMMARY_IN_POPUP(String store) {
        return Target.the("Vendor fee in summary of store " + store + " create drop popup")
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//dt[text()='Total payment']/following-sibling::dd[@class='vendor-fee']");

    }

    public static Target TOTAL_WEIGHT_SUMMARY_IN_POPUP(String store) {
        return Target.the("Total weight in summary " + store + " create drop popup")
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//dt[text()='Total payment']/following-sibling::dd[@class='total-weight']");
    }

    /**
     * Popup Create Drop - SOS Suggestions
     */

    public static Target STORE_NAME_SOS_SUGGESTION = Target.the("Store name in sos suggestion")
            .locatedBy("//div[@class='drop-suggestion-section']//div[@class='store-name']");

    public static Target DESCRIPTION_SOS_SUGGESTION = Target.the("Description in sos suggestion")
            .locatedBy("//div[@class='drop-suggestion-section']//div[@class='description']");

    public static Target APPLY_BUTTON_SOS_SUGGESTION(String store) {
        return Target.the("Apply button in sos suggestion")
                .locatedBy("(//span[text()='" + store + "']//ancestor::div/following-sibling::div//div[contains(@class,'suggestion')]//button)[1]");
    }

    public static Target APPLIED_BUTTON_SOS_SUGGESTION(String store) {
        return Target.the("Applied button in sos suggestion")
                .locatedBy("(//span[text()='" + store + "']//ancestor::div/following-sibling::div//div[contains(@class,'suggestion')]//button/span[text()='Applied'])[1]");
    }

    public static Target REJECT_BUTTON_SOS_SUGGESTION(String store) {
        return Target.the("Reject button in sos suggestion")
                .locatedBy("(//span[text()='" + store + "']//ancestor::div/following-sibling::div//div[contains(@class,'suggestion')]//button)[2]");
    }

    /**
     * Popup Create Drop - Create PO
     */
    public static Target CREATE_PO(String store) {
        return Target.the("Create po of store " + store + " in create drop popup")
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//div[contains(@class,'create-po')]/div");
    }

    public static Target D_TEXTBOX_CREATE_PO(String store, String title) {
        return Target.the("textbox of create PO of store " + store)
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//div[contains(@class,'create-po')]/parent::div/following-sibling::div//label[text()='" + title + "']//following-sibling::div//input");
    }

    public static Target D_POD_BUTTON_CREATE_PO(String store) {
        return Target.the("Button Add a POD of create PO of " + store)
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//div[contains(@class,'create-po')]/parent::div/following-sibling::div//label[text()='Proof of delivery']//following-sibling::div//button//span[text()='Add a POD']");
    }

    public static Target D_POD_NAME_CREATE_PO(String store, String fileName) {
        return Target.the("File name POD of create PO of " + store)
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//div[contains(@class,'create-po')]/parent::div/following-sibling::div//label[text()='Proof of delivery']//following-sibling::div//div[text()='" + fileName + "']");
    }

    public static Target D_POD_UPLOAD_CREATE_PO(String store) {
        return Target.the("Button Add a POD of create PO of " + store)
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//div[contains(@class,'create-po')]/parent::div/following-sibling::div//label[text()='Proof of delivery']//following-sibling::div//input[@type='file']");
    }

    public static Target D_COPY_PO_BUTTON(String store) {
        return Target.the("Use this info for all drops " + store)
                .locatedBy("//span[text()='" + store + "']/ancestor::div/following-sibling::div//button//span[contains(text(),'Use this info for all drops')]");
    }

    /**
     * Drop Result
     */


    public static Target CHECKBOX_DROP_IN_RESULT(String drop) {
        return Target.the("Checkbox drop in result")
                .locatedBy("//a[text()='" + drop + "']/parent::td/preceding-sibling::td/label");
    }


    public static Target DROP_ID(String dropID) {
        return Target.the("Drop ID " + dropID + " in drop result")
                .locatedBy("(//div[@class='drop-section']//a[text()='" + dropID + "'])[1]");
    }

    public static Target DROP_ID_INDEX(String index) {
        return Target.the("Drop index " + index + " in drop result")
                .locatedBy("(//div[@class='drop-section']//td[@class='name']/a)[" + index + "]");
    }

    public static Target GET_DROP_ID(String store, String index) {
        return Target.the("Drop ID of store " + store + " in drop result")
                .locatedBy("(//div[@class='drop-section']//td[text()='" + store + "']/parent::tr/preceding-sibling::tr//td[@class='name']/a)[" + index + "]");
    }

    public static Target DROP_ID_FIRST_RESULT = Target.the("Checkbox in drop result")
            .locatedBy("(//div[@class='drop-section']//td[@class='id']/a)[1]");


    public static Target CHECKBOX_IN_DROP_RESULT = Target.the("Checkbox in drop result")
            .locatedBy("(//div[@class='drop-section']//tbody//td[@class='check']/label)[1]");

    public static Target SOS_IN_DROP_RESULT1(String po) {
        return Target.the("Sos in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='" + po + "']/parent::td/following-sibling::td[contains(@class,'small-order-surcharge')]/span");
    }

    public static Target SOS_HELP_IN_DROP_RESULT = Target.the("Sos help icon in drop result")
            .locatedBy("((//div[@class='drop-section']//tbody//td[contains(@class,'small-order-surcharge')]/span)[2])[1]");

    public static Target FUEL_IN_DROP_RESULT1(String po) {
        return Target.the("Fuel surcharge in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='" + po + "']/parent::td/following-sibling::td[contains(@class,'logistics-surcharge')]");
    }

    public static Target TOTAL_PAYMENT_IN_DROP_RESULT1(String po) {
        return Target.the("Total payment in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='" + po + "']/parent::td/following-sibling::td[contains(@class,'total-payment')]/span");
    }

    public static Target TOTAL_ORDERED_IN_DROP_RESULT1(String po) {
        return Target.the("Total ordered in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='" + po + "']/parent::td/following-sibling::td[contains(@class,'total-ordered')]");
    }

    public static Target VENDOR_FEE_IN_DROP_RESULT1(String po) {
        return Target.the("Total ordered in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='" + po + "']/parent::td/following-sibling::td[contains(@class,'vendor-fee')]");
    }

    public static Target ADD_SUB_IN_DROP_PURCHASE_RESULT(String dropID) {
        return Target.the("Delete button of drop id " + dropID + " in drop result")
                .locatedBy("((//a[text()='" + dropID + "']/parent::td/following-sibling::td/button)[2])[1]");
    }

    public static Target DELETE_IN_DROP_RESULT(String dropID) {
        return Target.the("Delete button of drop id " + dropID + " in drop result")
                .locatedBy("((//a[text()='" + dropID + "']/parent::td/following-sibling::td/button)[2])[1]");
    }

    public static Target ADD_SUB_IN_DROP_NO_PURCHASE_RESULT(String dropID) {
        return Target.the("Delete button of drop id " + dropID + " in drop result")
                .locatedBy("((//a[text()='" + dropID + "']/parent::td/following-sibling::td/button)[1])[1]");
    }

    public static Target FLOWSPACE_STATUS_IN_DROP_RESULT1(String dropID) {
        return Target.the("Flowspace status of drop id " + dropID + " in drop result")
                .locatedBy("//div[@class='drop-section']//a[text()='"+dropID+"']/parent::td/following-sibling::td[contains(@class,'flowspace')]//div[@class='status-tag']");
    }



    /**
     * Drop Result - SOS History change tooltip
     */
    public static Target VALUE_IN_HISTORY_SOS(int index) {
        return Target.the("Value in history change sos " + index)
                .locatedBy("(//div[@role='tooltip' and @x-placement]//td[@class='value']/span)[" + index + "]");
    }

    public static Target REASON_IN_HISTORY_SOS(int index) {
        return Target.the("Reason in history change sos " + index)
                .locatedBy("(//div[@role='tooltip' and @x-placement]//td[@class='reason'])[" + index + "]");
    }

    public static Target NOTE_IN_HISTORY_SOS(int index) {
        return Target.the("Note in history change sos " + index)
                .locatedBy("(//div[@role='tooltip' and @x-placement]//td[@class='note'])[" + index + "]");
    }


    public static Target UPDATED_BY_IN_HISTORY_SOS(int index) {
        return Target.the("Updated by in history change sos " + index)
                .locatedBy("(//div[@role='tooltip' and @x-placement]//td[@class='initated-by'])[" + index + "]");
    }

    public static Target DATE_IN_HISTORY_SOS(int index) {
        return Target.the("Date in history change sos")
                .locatedBy("(//div[@role='tooltip' and @x-placement]//td[@class='date'])[" + index + "]");
    }


    /**
     * Drop Result - Detail
     */

    public static Target SUB_INVOICE_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Sos in drop result")
                .locatedBy("//div[@class='drop-section']//td[@class='sub-invoice']/div[text()='" + subInvoice + "']");
    }

    public static Target REGION_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Region in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[contains(@class,'region')]/span");
    }

    public static Target STORE_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Store in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[contains(@class,'store')]");
    }

    public static Target ORDER_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Order in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[contains(@class,'order')]/a");
    }

    public static Target SOS_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Sos in drop result")
                .locatedBy("(//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'small-order-surcharge')]/span)[1]");
    }

    public static Target SOS_HELP_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Sos history change in drop result")
                .locatedBy("(//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'small-order-surcharge')]/span)[2]\n");
    }

    public static Target FUEL_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Fuel in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'logistics')]");
    }

    public static Target TOTAL_PAYMENT_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Total payment in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-payment')]");
    }

    public static Target TOTAL_ORDERED_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Total ordered in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-ordered')]");
    }

    public static Target VENDOR_FEE_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Vendor fee in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'vendor-fee')]");
    }

    public static Target TOTAL_WEIGHT_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Total weight in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'total-weight')]");
    }

    public static Target ETA_IN_DROP_RESULT(String subInvoice) {
        return Target.the("ETA in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'eta')]/span");
    }

    public static Target DELETE_SUB_IN_DROP_RESULT(String subInvoice) {
        return Target.the("Button delete subinvoice in drop result")
                .locatedBy("//div[@class='drop-section']//div[text()='" + subInvoice + "']/parent::td/following-sibling::td[contains(@class,'actions')]/button");
    }

    /**
     * Add Sub invoice
     */

    public static Target ADD_TO_DROP_POPUP = Target.the("Add to drop popup")
            .locatedBy("//div[@role='dialog']//span[@class='title' and contains(text(),'Add to drop')]");

    public static Target CHECKBOX_IN_DROP_POPUP(String subInvoice) {
        return Target.the("Checkbox in drop popup")
                .locatedBy("//div[@id='global-dialogs']//div[text()='" + subInvoice + "']/parent::td/preceding-sibling::td[@class='check']/label");
    }

    public static Target ADD_TO_DROP_BUTTON_IN_POPUP = Target.the("Add to drop button in add to drop popup")
            .locatedBy("//div[@role='dialog']//span[@class='title' and contains(text(),'Add to drop')]");

    public static Target ICON_CLEAR_IN_MULTI_DROPDOWN(String title) {
        return Target.the("Icon clear value in multi dropdown textbox")
                .locatedBy("//div[@id='global-dialogs']//label[text()='" + title + "']/following-sibling::div//i[contains(@class,'icon-close')]");
    }


    /**
     * Action bar Create purchase order
     */

    public static Target SELECT_IN_CREATE_PO_ACTION_BAR = Target.the("Selected drop in create purchase order action bar")
            .locatedBy("//span[contains(text(),'drop selected')]/strong");

    public static Target TOTAL_PAYMENT_CREATE_PO_ACTION_BAR = Target.the("Total payment in create purchase order action bar")
            .locatedBy("//span[contains(text(),'Total payment:')]/strong");

    public static Target VENDOR_FEE_CREATE_PO_ACTION_BAR = Target.the("Vendor service fee in create purchase order action bar")
            .locatedBy("//span[contains(text(),'Vendor service fee:')]/strong");

    /**
     * Create purchase order popup
     */

    public static Target CREATE_PO_POPUP = Target.the("Create purchase order popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Push drop to LP']");

    /**
     * Reason change SOS popup
     */

    public static Target REASON_POPUP = Target.the("Reason popup")
            .locatedBy("//div[@id='global-dialogs']//span[@class='title' and text()='Reason']");

    public static Target REASON_TEXTBOX = Target.the("Reason textbox in reason popup")
            .locatedBy("//label[text()='Reason']/following-sibling::div//input");

    public static Target ADDITIONAL_NOTE_TEXTAREA = Target.the("Reason textbox in reason popup")
            .locatedBy("//label[text()='Additional note']/following-sibling::div//textarea");

    public static Target TOTAL_RESULT_SHOW_FOUND = Target.the("Total result found in add order to drop")
            .locatedBy("//div[@id='global-dialogs']//strong[@class='page' and text()='0']");

    /**
     * Flow space history popup
     */

    public static Target TOTAL_RESULT_S1HOW_FOUND = Target.the("Total result found in add order to drop")
            .locatedBy("//div[@id='global-dialogs']//strong[@class='page' and text()='0']");
}
