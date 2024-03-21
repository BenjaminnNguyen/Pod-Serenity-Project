package cucumber.user_interface.admin.vendors;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorCompaniesPage {

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .locatedBy("//button/span[text()='Show filters']");

    public static Target REFRESH_PAGE_BUTTON = Target.the("Refresh page")
            .locatedBy("(//header//div[@class='actions']//button)[2]");

    public static Target DYNAMIC_SEARCH_TEXTBOX(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .locatedBy("//div[contains(@data-field,'q[" + fieldName + "]')]//input");
    }

    public static Target PREPAY_ITEM_DROPDOWN(String value) {
        return Target.the("Item in prepayment dropdown")
                .locatedBy("//div[contains(@class,'pay-early')]//div[@class='el-scrollbar']//span[text()='" + value + "']");
    }

    public static Target ACH_ITEM_DROPDOWN(String value) {
        return Target.the("Item in ach dropdown")
                .locatedBy("//div[contains(@class,'ach')]//div[@class='el-scrollbar']//span[text()='" + value + "']");
    }

    /**
     * Result table
     */
    public static Target D_RESULT(String value) {
        return Target.the(value + " in result table")
                .locatedBy("//td[contains(@class,'" + value + "')]//span");
    }

    public static Target D_CHECKBOX_RESULT(String vendorCompany) {
        return Target.the("Checkbox of vendor company" + vendorCompany)
                .locatedBy("//span[@data-original-text='" + vendorCompany + "']//ancestor::td/preceding-sibling::td/div/input");
    }


    public static Target NAME_RESULT(String value) {
        return Target.the(value + " in result table")
                .locatedBy("//span[contains(@data-original-text,'" + value + "')]");
    }

    public static Target DELETE_RESULT_BUTTON(String name) {
        return Target.the("Delete result button")
                .locatedBy("(//span[@data-original-text='" + name + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button)[2]");
    }

    public static Target EDIT_RESULT_BUTTON(String name) {
        return Target.the("Delete result button")
                .locatedBy("(//span[@data-original-text='" + name + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button)[1]");
    }


    public static Target PREPAYMENT_IN_RESULT(String value) {
        return Target.the("Prepayment in result table")
                .locatedBy("//td[contains(@class,'two-percent-fifteen')]//span[text()='" + value + "']");
    }

    /**
     * Vendor company create new
     */
    public static Target CREATE_NEW_VENDOR_COMPANY_BUTTON = Target.the("Create new vendor company button")
            .locatedBy("//div[@class='page-header']//button//span[text()='Create']");

    public static Target CREATE_NEW_VENDOR_COMPANY_LABEL = Target.the("Create new vendor company popup label")
            .locatedBy("//div[@role='dialog']//span[contains(@class,'title')]");

    public static Target D_CREATE_TEXTBOX(String title) {
        return Target.the(title + " textbox in create vendor company")
                .locatedBy("(//label[text()='" + title + "']//following-sibling::div//input)[1]");
    }

    public static Target D_CREATE_TEXTBOX1(String title) {
        return Target.the(title + " textbox in create vendor company")
                .locatedBy("(//label[contains(text(),'" + title + "')]//following-sibling::div//input)[1]");
    }

    public static Target D_CREATE_CHECKBOX(String title) {
        return Target.the(title + " checkbox in create vendor company")
                .locatedBy("//label[text()='" + title + "']//following-sibling::div//div[contains(@class,'switch')]");
    }

    public static Target STREET_2_TEXTBOX = Target.the("Create new vendor company street 2 textbox")
            .locatedBy("(//label[text()='Street']//parent::div//following-sibling::div//input)[2]");

    public static Target D_ERROR_CREATE(String value) {
        return Target.the(value + " in result table")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div/div[contains(@class,'error')]");
    }

    public static Target SIMILAR_DESCRIPTION = Target.the("Similar description")
            .locatedBy("//p[@class='el-alert__description']/div[@class='text']");

    public static Target SIMILAR_VENDOR_COMPANY(String vendorCompany) {
        return Target.the("Similar vendor company")
                .locatedBy("//p[@class='el-alert__description']//span[text()='" + vendorCompany + "']");
    }

    /**
     * Vendor company detail
     */

    public static Target REFRESH_BUTTON = Target.the("Refresh button")
            .locatedBy("//div[@class='actions']//button");

    public static Target DETAIL_STATE = Target.the("State of vendor company")
            .locatedBy("//div[@class='status-tag']");

    public static Target DETAIL_TITLE = Target.the("Title of vendor company")
            .locatedBy("(//div[@class='title']//span)[1]");

    public static Target DETAIL_STATE_VALUE(String value) {
        return Target.the("State of vendor company")
                .locatedBy("//div[@class='status-tag' and text()='" + value + "']");
    }

    public static Target D_DETAIL(String value) {
        return Target.the(value + " in vendor company")
                .locatedBy("//span[@class='" + value + "']");
    }

    public static Target D_DETAIL_1(String title, String value) {
        return Target.the(title + " in vendor company")
                .locatedBy("//div[contains(@class,'" + title + "')]//span[text()='" + value + "']");
    }


    public static Target D_DETAIL_EDIT(String value) {
        return Target.the(value + " in vendor company")
                .locatedBy("(//dt[text()='" + value + "']/following-sibling::dd/div/span)[1]");
    }

    public static Target REGION_MOV(String region) {
        return Target.the(region + " in vendor company")
                .locatedBy("//dt[normalize-space()='" + region + "']/following-sibling::dd/div");
    }

    public static Target ADDRESS_DETAIL = Target.the("Address in detail")
            .locatedBy("//div[@class='address-stamp']");


    public static Target REFERRED_NAME = Target.the("Referred of vendor company")
            .locatedBy("//dt[text()='Referred by']//following-sibling::dd//div[@class='content el-popover__reference']//span");

    public static Target REFERRED_NAME_EDIT = Target.the("Referred of vendor company edit")
            .locatedBy("//dt[text()='Referred by']//following-sibling::dd//div[@class='content el-popover__reference']");

    public static Target LIMIT_TYPE = Target.the("Limit type")
            .locatedBy("//span[@class='limit-type']");

    public static Target LIMIT_TYPE_INPUT = Target.the("Limit type")
            .locatedBy("//div[@class='el-select entity-select regional-limit-type-select']//input[@placeholder='Select']");

    public static Target LIMIT_TYPE_UPDATE = Target.the("Limit type update")
            .locatedBy("//div[contains(@style,'position: absolute;')]//div[@class='actions']/button[text()='Update']");

    public static Target REFERRED_EDIT = Target.the("Referred of vendor company edit")
            .locatedBy("//div[contains(@class,'buyer-company')]");

    public static Target LIST_REFERRED_CLOSE = Target.the("List referred close")
            .locatedBy("//div[@role='tooltip' and @x-placement]//span[contains(@class,'tags')]/following-sibling::i");

    public static Target REFERRED_LABEL = Target.the("List referred close")
            .locatedBy("//div[@x-placement]//label[text()='Referred by']");

    public static Target SELECTED_REFERRED = Target.the("List referred close")
            .locatedBy("//span[@class='el-select__tags-text']");

    public static Target CHECKBOX_GENERAL_VALUE(String title, String value) {
        return Target.the(title + " in vendor company")
                .locatedBy("(//dt[text()='" + title + "']/following-sibling::dd//span[text()='" + value + "'])[1]");
    }

    public static Target CHECKBOX_GENERAL(String title) {
        return Target.the(title + " in vendor company")
                .locatedBy("(//dt[text()='" + title + "']/following-sibling::dd//span)[1]");
    }

    public static Target ACTIVE_HISTORY_ICON = Target.the("Active or deactivate history icon")
            .locatedBy("//span[contains(@class,'help-icon')]");

    /**
     * Popup history active - deactivate
     */

    public static Target ACTIVE_HISTORY_STATE = Target.the("Active or deactivate history state")
            .locatedBy("(//div[@x-placement]//td[@class='value'])[1]");

    public static Target ACTIVE_HISTORY_UPDATE_BY = Target.the("Active or deactivate history update by")
            .locatedBy("(//div[@x-placement]//td[@class='initated-by'])[1]");

    public static Target ACTIVE_HISTORY_UPDATE_ON = Target.the("Active or deactivate history update by")
            .locatedBy("(//div[@x-placement]//td[@class='date'])[1]");

    /**
     * Vendor company detail - Custom field
     */
    public static Target CUSTOM_FIELD_DETAIL(String title, String value) {
        return Target.the(title + " custom field in vendor company")
                .locatedBy("(//dt[contains(text(),'" + title + "')]//following-sibling::dd//span[@class='" + value + "'])[1]");
    }

    public static Target CUSTOM_FIELD_DETAIL_FILE = Target.the("Custom field file in vendor company")
            .locatedBy("(//dt[contains(text(),'File')]//following-sibling::dd//div[@class='choose ellipsis'])[1]");

    public static Target CUSTOM_FIELD_FILE_REMOVE_BUTTON = Target.the("Custom field file in vendor company remove button")
            .locatedBy("(//dt[contains(text(),'File')]//following-sibling::dd//button)[1]");

    public static Target CUSTOM_FIELD_FILE_UPLOAD = Target.the("Custom field file in vendor company upload button")
            .locatedBy("(//dt[contains(text(),'File')]//following-sibling::dd//input)[1]");

    /**
     * Vendor company detail - COMPANY DOCUMENTS
     */

    public static Target COI_HELP_ICON = Target.the("COI help icon")
            .locatedBy("//span[text()='COI']/following-sibling::span");

    public static Target COI_HELP_POPUP = Target.the("COI help popup")
            .locatedBy("//div[@x-placement]/div");

    public static Target COI_HELP_POPUP_LINK = Target.the("COI help popup link")
            .locatedBy("//a[text()='Vendor Service Agreement']");

    public static Target COI_FILE_PREVIEW = Target.the("COI file preview")
            .locatedBy("//div[@id='pane-coi']//label[@class='preview']");

    public static Target COI_FILE_PREVIEW_TOOLTIP = Target.the("COI file preview tool tip")
            .locatedBy("//div[text()='Choose a COI file']");

    public static Target COI_FILE_PREVIEW_ICON_TOOLTIP = Target.the("COI file preview icon tool tip")
            .locatedBy("//div[text()='The maximum file size is 10MB']");

    public static Target COI_FILE_PREVIEW_ICON = Target.the("COI file preview tool tip")
            .locatedBy("//div[text()='Allowed formats: jpg, jpeg, pdf, docx']/following-sibling::div//div[@class='icon']");

    public static Target COI_START_DATE_TEXTBOX = Target.the("COI start date textbox")
            .locatedBy("//label[text()='Start date']/following-sibling::div//input");

    public static Target COI_EXPIRY_DATE_TEXTBOX = Target.the("COI expiry date textbox")
            .locatedBy("//label[text()='Expiry date']/following-sibling::div//input");

    public static Target COI_UPLOAD_BUTTON = Target.the("COI upload file button")
            .locatedBy("//div[@id='pane-coi']//input[contains(@accept,'image/jpeg')]");

    public static Target OTHER_TAB = Target.the("Other tab in company document")
            .locatedBy("//div[text()='Others']");

    public static Target OTHER_TAB_NOTE1 = Target.the("Other tab note 1 in company document")
            .locatedBy("//div[@id='pane-other']//div[text()='Allowed formats: jpg, jpeg, pdf, docx']");

    public static Target OTHER_TAB_NOTE2 = Target.the("Other tab note 2 in company document")
            .locatedBy("//div[@id='pane-other']//div[text()='You can upload up to 10 files']");

    public static Target OTHER_TAB_UPLOAD_FILE = Target.the("Other tab upload file in company document")
            .locatedBy("//div[@id='pane-other']//label[@class='preview']//input");

    public static Target OTHER_TAB_DESCRIPTION = Target.the("Other tab description in company document")
            .locatedBy("//div[@id='pane-other']//div[@class='description']//input");

    /**
     * Bulk update vendor companies
     */
    public static Target EDIT_ACTION_BAR = Target.the("Edit button in buyer company action bar")
            .locatedBy("//div[@class='buyer-company-action-bar']//span[text()='Edit']");

    public static Target CLEAR_ACTION_BAR = Target.the("Clear button in buyer company action bar")
            .locatedBy("//div[@class='buyer-company-action-bar']//span[text()='Clear selection']");

    public static Target D_TEXT_BULK_UPDATE(String title) {
        return Target.the("Textbox update bulk vendor companies")
                .locatedBy("(//div[@role='dialog']//label[text()='" + title + "']/following-sibling::div//input)[1]");
    }
}
