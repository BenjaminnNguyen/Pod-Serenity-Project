package cucumber.user_interface.admin;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CommonAdminForm {
    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.xpath("//button[contains(@class,'search')]"));

    public static Target RESET_BUTTON = Target.the("Reset button")
            .located(By.xpath("//button[contains(@class,'reset')]"));

    public static Target SEARCH_BUTTON_IN_POPUP = Target.the("Search button in popup")
            .located(By.xpath("//div[@id='global-dialogs']//button[contains(@class,'search')]"));

    public static Target RESET_BUTTON_IN_POPUP = Target.the("Reset button in popup")
            .located(By.xpath("//div[@id='global-dialogs']//button[contains(@class,'reset')]"));

    public static Target EDIT_BUTTON = Target.the("Edit button")
            .located(By.xpath("(//td[contains(@class,'actions')]//button)[1]"));

    public static Target BACK_BUTTON = Target.the("Edit button")
            .located(By.xpath("//div[@class='back']/button"));

    public static Target LOADING_SPINNER = Target.the("Loading spinner")
            .located(By.xpath("//div[@class='el-loading-mask' and not(@style='display: none;')]"));

    public static Target SWITCH = Target.the("Swicth")
            .located(By.xpath("//div[@class='el-loading-mask' and not(@style='display: none;')]"));

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .located(By.xpath("//span[text()='Show filters']/parent::button"));

    public static Target COLLAPSE_FILTER = Target.the("Collapse Filters")
            .locatedBy("//span[text()='Collapse']/parent::button");

    public static Target SHOW_FILTER_IN_POPUP = Target.the("Show Filters in popup")
            .located(By.xpath("//div[@id='global-dialogs']//span[text()='Show filters']/parent::button"));

    public static Target COLLAPSE_FILTER_IN_POPUP = Target.the("Collapse Filters in popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Collapse']/parent::button");

    public static Target NO_DATA = Target.the("NO_DATA")
            .located(By.xpath("//div[contains(@x-placement,'start')]/p[normalize-space()='No matching data' or normalize-space()='No data']"));

    public static Target CREATE_BUTTON_ON_HEADER = Target.the("Create request button")
            .located(By.xpath("//div[@class='page-header']//button//span[text()='Create']"));

    public static Target NO_DATA1 = Target.the("NO_DATA")
            .located(By.xpath("//div[contains(@x-placement,'start')]//p[contains(text(),'No data')]|//div[contains(@x-placement,'start')]//li[not(@style)]//span[text()='-']|(//div[contains(@x-placement,'start')]/p[normalize-space()='No matching data'])[last()]"));

    public static Target DYNAMIC_INPUT(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("//label[normalize-space()='" + fieldName + "']/following-sibling::div//input"));
    }

    public static Target DYNAMIC_INPUT2(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("//label[normalize-space()='" + fieldName + "']/following-sibling::div//input | //*[contains(@class,'" + fieldName + "')]//input"));
    }

    public static Target DYNAMIC_INPUT_PLACEHOLDER(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("//input[contains(@placeholder,'" + fieldName + "')]"));
    }

    public static Target DYNAMIC_TOOLTIP_INPUT() {
        return Target.the("Textbox")
                .located(By.xpath("//div[@role = 'tooltip' and @x-placement]//input"));
    }

    public static Target DYNAMIC_TOOLTIP_INPUT(String label) {
        return Target.the("DYNAMIC_TOOLTIP_INPUT " + label)
                .located(By.xpath("//div[@role = 'tooltip' and @x-placement]//label[normalize-space()='" + label + "']//following-sibling::div//input"));
    }

    public static Target DYNAMIC_INPUT2(String label, int i) {
        return Target.the("")
                .located(By.xpath("(//label[normalize-space()='" + label + "']/following-sibling::div//input)[" + i + "]"));
    }

    public static Target DYNAMIC_SEARCH_TEXTBOX(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("//div[contains(@data-field,'" + fieldName + "')]//input"));
    }

    public static Target D_SEARCH_TEXTBOX_IN_POPUP(String fieldName) {
        return Target.the("Textbox " + fieldName + " in popup")
                .located(By.xpath("//div[@class='el-dialog__body']//div[contains(@data-field,'" + fieldName + "')]//input"));
    }

    public static Target D_SEARCH_ICON_CLOSE_IN_TEXTBOX(String fieldName) {
        return Target.the("Icon close in textbox of " + fieldName)
                .located(By.xpath("//label[text()='" + fieldName + "']/following-sibling::div//i[contains(@class,'close')]"));
    }


    public static Target DYNAMIC_SEARCH_TEXTBOX_MULTI(String fieldName) {
        return Target.the("Textbox multi" + fieldName)
                .located(By.xpath(" //div[contains(@data-field,'" + fieldName + "')]//span[@class='el-select__tags-text']"));
    }

    public static Target DYNAMIC_SEARCH_TEXTBOX2(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("(//div[contains(@data-field,'" + fieldName + "')]//input)[last()]"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//div[@class='el-scrollbar']//*[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN3(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//div[@class='el-scrollbar']//*[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_2(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//div[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_3(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//*[text()[normalize-space()=\"" + value + "\"]]"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_4(String value) {
        return Target.the(value)
                .located(By.xpath("//ul[contains(@x-placement,'') and contains(@class,'el-dropdown')]//*[text()='" + value + "']"));
    }

    public static Target FIRST_ITEM_DROPDOWN = Target.the("FIRST_ITEM_DROPDOWN")
            .located(By.xpath("//div[@x-placement]//li[contains(@class,'el-select-dropdown__item')]/div"));


    public static Target DYNAMIC_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_HEADER_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[@class='page-header']//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_BUTTON_DISABLE(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button[@disabled]//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_ALERT(String alert) {
        return Target.the("ALERT " + alert)
                .locatedBy("//div[@role='alert']//*[contains(text(),\"" + alert + "\")]");
    }

    public static Target DYNAMIC_DIALOG(String alert) {
        return Target.the("ALERT " + alert)
                .locatedBy("//div[@role='dialog']//*[contains(text(),'" + alert + "')]");
    }

//    public static Target NO_DATA = Target.the("Message No data")
//            .located(By.xpath("//div[contains(@x-placement,'start')]//p[contains(text(),'No data')]"));

    public static Target DYNAMIC_DIALOG_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[@role='dialog']//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_GLOBAL_DIALOG_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[@id='global-dialogs']//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_DIALOG_INPUT() {
        return Target.the("")
                .located(By.xpath("//div[@role='dialog']//input"));
    }

    public static Target DYNAMIC_DIALOG_INPUT(String label) {
        return Target.the("")
                .located(By.xpath("//label[normalize-space()='" + label + "']/following-sibling::div//input"));
    }

    public static Target DYNAMIC_DIALOG_INPUT2(String label, int i) {
        return Target.the("")
                .located(By.xpath("(//label[normalize-space()='" + label + "']/following-sibling::div//input)[" + i + "]"));
    }

    public static Target DYNAMIC_DIALOG_TEXTAREA(String label) {
        return Target.the("")
                .located(By.xpath("//label[normalize-space()='" + label + "']/following-sibling::div//textarea"));
    }

    public static Target DATE_ON_POPUP(String date) {
        return Target.the("Date")
                .locatedBy("//div[@x-placement]//td[contains(@class,'" + date + "')]");
    }

    public static Target DUPLICATE(String st) {
        return Target.the("Duplicate button")
                .locatedBy("//*[contains(text(),'" + st + "')]//ancestor::tr/td[contains(@class,'actions')]//*[contains(@data-icon,'copy')]");
    }

    public static Target DELETE(String st) {
        return Target.the("Delete button")
                .locatedBy("//*[contains(text(),'" + st + "')]//ancestor::tr/td[contains(@class,'actions')]//*[contains(@data-icon,'trash')]");
    }

    public static Target DYNAMIC_SPAN_TEXT(String st) {
        return Target.the("Date")
                .locatedBy("//span[normalize-space()='" + st + "']");
    }

    public static Target DYNAMIC_DIALOG_SPAN_TEXT(String st) {
        return Target.the("Date")
                .locatedBy("//div[@role='dialog']//span[normalize-space()='" + st + "']");
    }

    public static Target D_MESSAGE_POPUP(String message) {
        String xpath = "//p[contains(text(),'" + message + "')]";
        if (message.contains("'"))
            xpath = "//p[contains(text(),\"" + message + "\")]";
        return Target.the("Message")
                .locatedBy(xpath);
    }

    public static Target REFRESH_BUTTON = Target.the("REFRESH_BUTTON")
            .located(By.xpath("//button[contains(@class,'el-button el-button--danger')]/following-sibling::button"));

    public static Target TABLE_DATE = Target.the("TABLE_DATE")
            .located(By.xpath("//table[@class='el-date-table']"));

    public static Target ALERT_CLOSE_BUTTON = Target.the("Alert close button")
            .located(By.xpath("//div[@class='el-notification__closeBtn el-icon-close']"));

    public static Target POPUP_CLOSE_BUTTON = Target.the("Close popup")
            .locatedBy("//i[@class='el-dialog__close el-icon el-icon-close']");

    public static Target POPUP_CLOSE_BUTTON1 = Target.the("Close popup")
            .locatedBy("//div[@id='global-dialogs']//i[@class='el-dialog__close el-icon el-icon-close']");


    public static Target CLOSE_POPUP = Target.the("Alert close button")
            .located(By.xpath("//button[@aria-label='Close']"));

    public static Target CLOSE_POPUP1 = Target.the("Alert close button")
            .located(By.xpath("//div[@role='dialog']//button[@aria-label='Close']"));

    public static Target CLOSE_POPUP2 = Target.the("Alert close button")
            .locatedBy("(//div[@role='dialog' and not(contains(@style,'display: none'))]//button[@aria-label='Close'])[last()]");

    public static Target CURRENTDATE_IN_DATETIME = Target.the("Current date in date time")
            .located(By.xpath("//div[@aria-hidden='false']/following-sibling::div//table[contains(@class,'date-table')]//td[contains(@class,'current')]"));

    public static Target START_DATE_PICKUP = Target.the("Start date in pickup time popup")
            .located(By.xpath("(//div[contains(@class,'time-range-input')]//input)[1]"));

    public static Target END_DATE_PICKUP = Target.the("End date in pickup time popup")
            .located(By.xpath("(//div[contains(@class,'time-range-input')]//input)[2]"));

    public static Target ATTACHMENT_BUTTON = Target.the("Attachment button")
            .located(By.xpath("//input[@type='file']"));

    public static Target NO_DATA_RESULT = Target.the("Text no data")
            .locatedBy("//span[text()='No Data']");

    public static Target NO_DATA_RESULT_IN_POPUP = Target.the("Text no data in result popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='No Data']");

    public static Target ALERT_MESSAGE(String message) {
        String target = "//p[text()='" + message + "']";
        if (message.contains("'"))
            target = "//p[text()=\"" + message + "\"]";
        return Target.the("Message alert")
                .locatedBy(target);
    }

    /**
     * Date picker
     */
    public static Target PREVIOUS_YEAR_DATE_PICKER = Target.the("Previous year date picker")
            .locatedBy("//button[@aria-label='Previous Year']");

    public static Target NEXT_YEAR_DATE_PICKER = Target.the("Next year date picker")
            .locatedBy("//button[@aria-label='Next Year']");

    public static Target DATE_PICKER_HEADER = Target.the("Date picker header")
            .locatedBy("//span[@class='el-date-picker__header-label']");

    /**
     * Tooltip
     */
    public static Target TOOLTIP_TEXTBOX(int i) {
        return Target.the("Tooltip textbox")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//input)[" + i + "]");
    }

    public static Target TOOLTIP_TEXTAREA = Target.the("Tooltip textarea")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//textarea");

    public static Target TOOLTIP_TEXTBOX = Target.the("Tooltip textbox")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input");

    public static Target TOOLTIP_COMBOBOX = Target.the("Tooltip textbox")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder]");

    public static Target D_BUTTON_TOOLTIP = Target.the("Button")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//button)[1]"));

    public static Target D_BUTTON_SWITCH = Target.the("Button")
            .located(By.xpath("//div[@x-placement]//span[contains(@class,'el-switch__core')]"));

    public static Target D_BUTTON_CANCEL_TOOLTIP = Target.the("Button")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//button)[2]"));

    public static Target HELP_TOOLTIP(String field) {
        return Target.the("Help tooltip")
                .located(By.xpath("//*[text()='" + field + "']//*[contains(@class,'help')]|//*[@class='help-icon has-tooltip']//*[contains(text(),'" + field + "')]"));
    }

    public static Target DIALOG_HELP_TOOLTIP(String field) {
        return Target.the("Help tooltip")
                .located(By.xpath("//div[@x-placement]//*[contains(text(),'" + field + "')]/following-sibling::i"));
    }

    public static Target D_BUTTON_TOOLTIP(String button) {
        return Target.the("Button tooltip")
                .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//*[text()='" + button + "'])[1]"));
    }

    public static Target ANY_TEXT(String text) {
        String xpath = "//*[contains(text(),'" + text + "')]";
        if (text.contains("'")) {
            xpath = "//*[contains(text(),\"" + text + "\")]";
        }
        return Target.the("Any text")
                .located(By.xpath(xpath));
    }

    public static Target D_SORT_BY(String field, String type) {//ascending, descending
        return Target.the("Short field " + field + " by " + type)
                .located(By.xpath("//div[normalize-space()='" + field + "']//i[contains(@class,'sort-caret " + type + "')]"));
    }

    public static Target ICON_CIRCLE_DELETE = Target.the("Icon circle delete")
            .locatedBy("(//i[contains(@class,'el-icon-circle-close')])[last()]");

    public static Target ICON_CIRCLE_DELETE(String value) {
        return Target.the("Icon circle delete")
                .locatedBy("(//*[text()='" + value + "']/following-sibling::i[contains(@class,'el-icon')])[last()]");

    }

    /**
     * Result table
     */
    public static Target D_RESULT(String value, int i) {
        return Target.the(value + " in result table")
                .located(By.xpath("(//td[contains(@class,'" + value + "')])[" + i + "]"));
    }

    public static Target TITLE_PAGE = Target.the("Page title")
            .located(By.xpath("//div[@class='title']/span"));

    public static Target TITLE_POPUP = Target.the("Page title")
            .located(By.xpath("//div[@role='dialog']//span[contains(@class,'title')]"));

    public static Target REDIRECT_ICON(String value) {
        return Target.the(value)
                .located(By.xpath("//*[text()=\"" + value + "\"]/ancestor::dd//a[@class='navigate']"));
    }

    public static Target DIALOG_MESSAGE_TEXT = Target.the("DIALOG_MESSAGE_TEXT")
            .located(By.xpath("//div[@role='dialog']//div[contains(@class,'el-message-box__message')]"));

    /**
     * Edit visibility dialog
     */

    public static Target EDIT_VISIBILITY_BUTTON = Target.the("Edit visibility button")
            .located(By.xpath("//div[@class='actions']//span[contains(text(),'Edit visibility')]"));

    public static Target FIELD_EDIT_VISIBILITY(String value) {
        return Target.the("Field " + value + " in edit visibility dialog")
                .located(By.xpath("//div[@role='dialog']//span[text()='" + value + "']"));
    }

    /**
     * Filter preset search
     */

    public static Target FILTER_PRESET_BUTTON = Target.the("Filter preset button")
            .located(By.xpath("//li[text()='Save filter preset']"));

    public static Target SAVE_FILTER_PRESET_POPUP = Target.the("Save filter preset popup")
            .located(By.xpath("//div[@role='dialog']//span[text()='Save filter preset']"));

    public static Target SAVE_FILTER_PRESET_TYPE(String type) {
        return Target.the("Save filter preset type choose")
                .located(By.xpath("//div[@role='radiogroup']//span[text()='" + type + "']"));
    }

    public static Target SAVE_FILTER_NAME_TEXTBOX = Target.the("Save filter name textbox")
            .located(By.xpath("//label[text()='Preset name']/following-sibling::div//input"));

    public static Target FILTER_NAME_SAVED(String filterName) {
        return Target.the("Filter preset name saved")
                .located(By.xpath("(//ul[@class='el-dropdown-menu el-popper']//span[text()='" + filterName + "'])[1]"));
    }

    public static Target FILTER_NAME_SAVED_DELETE(String filterName) {
        return Target.the("Filter preset name saved delete button")
                .located(By.xpath("//span[text()='" + filterName + "']/parent::span/following-sibling::span"));
    }

    /**
     * Popup history active - deactivate
     */

    public static Target ACTIVE_HISTORY_STATE = Target.the("Active or deactivate history state")
            .located(By.xpath("(//div[@x-placement]//td[@class='value'])"));

    public static Target ACTIVE_HISTORY_UPDATE_BY = Target.the("Active or deactivate history update by")
            .located(By.xpath("(//div[@x-placement]//td[@class='initated-by'])[1]"));

    public static Target ACTIVE_HISTORY_UPDATE_ON = Target.the("Active or deactivate history update by")
            .located(By.xpath("(//div[@x-placement]//td[@class='date'])[1]"));

}
