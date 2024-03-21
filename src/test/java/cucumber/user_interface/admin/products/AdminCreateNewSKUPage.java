package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminCreateNewSKUPage {
    public static Target popup_STATE_FIELD = Target.the("The State field in the popup")
            .located(By.cssSelector("#pane-general .state-select input"));

    public static Target popup_ACTIVE_STATE = Target.the("The active state on the popup")
            .located(By.cssSelector("div.popper-state-select li:nth-child(1)"));

    public static Target popup_INACTIVE_STATE = Target.the("The inactive state on the popup")
            .located(By.cssSelector("div.popper-state-select li:nth-child(2)"));

    public static Target popup_DRAFT_STATE = Target.the("The Draft state on the popup")
            .located(By.cssSelector("div.popper-state-select li:nth-child(3)"));

    public static Target REGION_SPECIFIC_TAB = Target.the("Region-specific tab")
            .located(By.cssSelector("#tab-regions"));

    public static Target SPECIFIC_TAB(String tab) {
        return Target.the(tab + "specific tab")
                .located(By.xpath("//div[@role='tablist']//div[text()='" + tab + "']"));
    }

    public static Target REGION_SPECIFIC_TAB_PANE = Target.the("Default Region-specific tab")
            .located(By.xpath("//div[@id='pane-regions']//p[@class='el-alert__description']"));

    public static Target REGION_SPECIFIC_TAB_PANE(String tab) {
        return Target.the("Default Region-specific tab")
                .located(By.xpath("//div[@id='pane-" + tab + "s']//p[@class='el-alert__description']"));
    }

    public static Target REGION_SPECIFIC_EMPTY = Target.the("Region-specific empty")
            .located(By.xpath("//div[@class='regions empty']"));

    public static Target REGION_SPECIFIC_EMPTY(String tab) {
        return Target.the("Region-specific empty")
                .located(By.xpath("//div[@id='pane-" + tab + "s']//div[@class='stores empty']"));
    }

    public static Target REGION_SPECIFIC_ERROR = Target.the("Region-specific empty")
            .located(By.xpath("//div[@class='el-form-item__error']"));

    public static Target STORE_SPECIFIC_TAB = Target.the("Store Specific tab")
            .located(By.cssSelector("#tab-stores"));
    public static Target COMPANY_SPECIFIC_TAB = Target.the("Store Specific tab")
            .located(By.cssSelector("#tab-buyers"));

    public static Target MAIN_SKU = Target.the("The Main SKU field")
            .located(By.cssSelector("#pane-general .el-switch.position .el-switch__label"));
    public static Target MAIN_SKU_CHECKED = Target.the("The Main SKU field")
            .located(By.cssSelector("#pane-general .el-switch.position .is-active"));

    public static Target SELECT_STORE_REGION_FIELD = Target.the("Select Store Region field")
            .located(By.cssSelector("#pane-stores .add-store-form .region input"));

    public static Target SELECT_A_STORE_FIELD = Target.the("Select A Store field")
            .located(By.cssSelector("#pane-stores .add-store-form .store input"));

    public static Target THE_FIRST_STORE_ON_THE_SUGGESTION = Target.the("The first store on the suggestion")
            .located(By.cssSelector("div.popper-store-select li"));

    public static Target ADD_STORE_SPECIFIC_BUTTON = Target.the("Add Store Specific button")
            .located(By.cssSelector("#pane-stores .add-store-form .action button"));


    public static Target TAGS_COMBOBOX = Target.the("")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder]");

    public static Target SELECT_TAG = Target.the("SELECT_TAG")
            .locatedBy("(//input[@placeholder='Select a tag'])[last()]");

    public static Target TAGS_EXPIRY_DATE(String tag) {
        return Target.the("")
                .locatedBy("(//div[contains(text(),'" + tag + "')]/parent::div/following-sibling::div/input)[last()]");
    }

    public static Target TAGS_NAME(String tag) {
        return Target.the("")
                .locatedBy("//div[@class='tag-name has-tooltip' and text()='" + tag + "']");
    }


    // Store Specific Tab
    public static String CASE_PRICE_FIELD = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'case-price')]/input";

    public static Target CASE_PRICE_FIELD(String region) {
        return Target.the("").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div[contains(@class,'case-price')]/input");
    }

    public static Target MSRP_FIELD(String region) {
        return Target.the("").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div[contains(@class,'region-msrp')]/input");
    }

    public static Target AVAILABILITY_FIELD(String region) {
        return Target.the("").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div[contains(@class,'availability')]//input");
    }

    public static Target ARRIVING_AT(String region) {
        return Target.the("").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div[contains(@class,'receiving-date')]//input");
    }

    public static Target START_DATE(String region) {
        return Target.the("START_DATE").locatedBy("//div[text()='" + region + "']/parent::div/following-sibling::div[contains(@class,'tr time')]//label[text()='Start date']/following-sibling::div//input");
    }

    public static Target HISTORY_ICON(String region) {
        return Target.the("HISTORY_ICON " + region).locatedBy("//div[text()='" + region + "']/parent::div/following-sibling::div//div[@class='tr state']//span[@class='help-icon popover']");
    }

    public static Target HISTORY_AVAILABILITY_ICON(String region) {
        return Target.the("HISTORY_ICON " + region).locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//span[contains(text(),'Availability')]/following-sibling::span");
    }

    public static Target HISTORY_AVAILABILITY_ICON_BUYER_COMPANY(String buyer, String region) {
        return Target.the("HISTORY_AVAILABILITY_ICON_BUYER_COMPANY " + region).locatedBy("//div[text()='" + buyer + "']/ancestor::tbody//span[@data-original-text = '" + region + "' ]/ancestor::tr//div[contains(@class,'availability')]/following-sibling::span");
    }

    public static Target HISTORY_STATE_ICON_BUYER_COMPANY(String buyer, String region) {
        return Target.the("HISTORY_AVAILABILITY_ICON_BUYER_COMPANY " + region).locatedBy("//div[text()='" + buyer + "']/ancestor::tbody//span[@data-original-text = '" + region + "' ]/ancestor::tr//div[contains(@class,'status')]/following-sibling::span");
    }

    public static Target HISTORY_STATE_ICON_STORE(String store) {
        return Target.the("HISTORY_STATE_ICON_STORE " + store).locatedBy("//span[normalize-space()='" + store + "']/ancestor::tr//div[contains(@class,'status')]/following-sibling::span");
    }

    public static Target HISTORY_AVAILABILITY_ICON_STORE(String store) {
        return Target.the("HISTORY_STATE_ICON_STORE " + store).locatedBy("//span[normalize-space()='" + store + "']/ancestor::tr//div[contains(@class,'availability')]/following-sibling::span");
    }

    public static Target HISTORY_TOOLTIP() {
        return Target.the("HISTORY_TOOLTIP ").locatedBy("//div[@role = 'tooltip' and @x-placement]//table[@class='popper-help-text-table']");
    }

    public static Target HISTORY_AVAILABILITY_TOOLTIP() {
        return Target.the("HISTORY_TOOLTIP ").locatedBy("//div[@role = 'tooltip' and @x-placement]//table[@class='popper-help-text-table']");
    }

    public static Target HISTORY_TOOLTIP_STATE(int i) {
        return Target.the("HISTORY_TOOLTIP ").locatedBy("(//div[@role = 'tooltip' and @x-placement]//table[@class='popper-help-text-table']//td[@class='value'])[" + i + "]");
    }

    public static Target HISTORY_TOOLTIP_UPDATED_BY(int i) {
        return Target.the("HISTORY_TOOLTIP_UPDATED_BY ").locatedBy("(//div[@role = 'tooltip' and @x-placement]//table[@class='popper-help-text-table']//td[@class='initated-by'])[" + i + "]");
    }

    public static Target HISTORY_TOOLTIP_UPDATED_ON(int i) {
        return Target.the("HISTORY_TOOLTIP_UPDATED_ON ").locatedBy("(//div[@role = 'tooltip' and @x-placement]//table[@class='popper-help-text-table']//td[@class='date'])[" + i + "]");
    }

    public static Target START_DATE_REGION_MASS_EDIT(String region) {
        return Target.the("START_DATE_REGION_MASS_EDIT").locatedBy("//span[@data-original-text='" + region + "']//ancestor::td/following-sibling::td[3]//input");
    }

    public static Target START_DATE_REGION_MASS_EDIT2(String region) {
        return Target.the("START_DATE_REGION_MASS_EDIT2").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div//input[@placeholder='Start date']");
    }

    public static Target END_DATE(String region) {
        return Target.the("END_DATE").locatedBy("//div[text()='" + region + "']/parent::div/following-sibling::div[contains(@class,'tr time')]//label[text()='End date']/following-sibling::div//input");
    }

    public static Target END_DATE_REGION_MASS_EDIT(String region) {
        return Target.the("END_DATE_REGION_MASS_EDIT").locatedBy("//span[@data-original-text='" + region + "']//ancestor::td/following-sibling::td[4]//input");
    }

    public static Target END_DATE_REGION_MASS_EDIT2(String region) {
        return Target.the("").locatedBy("//div[text()='" + region + "']/ancestor::div[@class='record']//div//input[@placeholder='End date']");
    }

    public static String MSRP_FIELD = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'region-msrp')]/input";

    public static String MAX_MSRP_FIELD = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'msrp-high')]/input";

    public static String AVAILABILITY_FIELD = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'availability')]//input";

    public static Target IN_STOCK_STATE = Target.the("In Stock state")
            .located(By.cssSelector("div.popper-region-availability-0 li.el-select-dropdown__item:nth-child(1)"));

    public static Target OUT_OF_STOCK_STATE = Target.the("Out of Stock state")
            .located(By.cssSelector("div.popper-region-availability-0 li.el-select-dropdown__item:nth-child(2)"));

    public static String ARRIVING_AT = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'receiving-date')]//input";
    public static String CATEGORY = "//div[text()='%s']/ancestor::div[@class='record']//div[contains(@class,'out-of-stock-reason')]//input";

    public static Target CATEGORY(String category) {
        return Target.the("").locatedBy(
                "//div[text()='" + category + "']/ancestor::div[@class='record']//div[contains(@class,'out-of-stock-reason')]//input"
        );
    }

    public static Target EXPECTED_INVENTORY_STATE = Target.the("Expected inventory state")
            .located(By.cssSelector("div.popper-region-availability-0 li.el-select-dropdown__item:nth-child(4)"));

    public static Target INVENTORY_ARRIVING_DATE_FIELD = Target.the("The inventory arriving date field")
            .located(By.cssSelector("div.inventory-receiving-date input"));
    public static Target SKU_NAME_FIELD = Target.the("The Sku field")
            .located(By.cssSelector("div.name input"));

    public static Target UNITS_CASE = Target.the("The units/case")
            .located(By.cssSelector("div.case-units input"));

    public static Target MASTER_IMAGE = Target.the("Master image")
            .located(By.cssSelector("div.master-image .image-file-input input"));

    public static Target NO_MASTER_IMAGE = Target.the("Master image")
            .located(By.xpath("//div[contains(@class,'master-image')]//div[@class='image-file-input']//div[contains(@class,'image') and (contains(@style,'no_image') or contains(@style,'null'))]"));

    public static Target INDIVIDUAL_UNIT_UPC = Target.the("The unit UPC")
            .located(By.cssSelector("div.upc .el-input__inner"));

    public static Target INDIVIDUAL_UNIT_EAN_DROP = Target.the("The unit EAN")
            .located(By.xpath("//div[@class='el-select suffix el-select--small']//input[@placeholder='Select']"));

    public static Target CASE_UPC = Target.the("The case UPC")
            .located(By.cssSelector("div.case-upc input"));

    public static Target UPC_IMAGE = Target.the("The upc image")
            .located(By.cssSelector("div.upc-image input"));

    public static Target UPC_IMAGE_VALUE = Target.the("The upc image")
            .located(By.xpath("//div[contains(@class,'upc-image')]//div[@class='image-file-input']//div[contains(@class,'image') and (contains(@style,'no_image') or contains(@style,'null'))]"));

    public static Target CASE_IMAGE = Target.the("The case upc image")
            .located(By.cssSelector("div.case-upc-image input"));

    public static Target MASTER_CARTON_UPC = Target.the("Master Carton UPC")
            .located(By.cssSelector("div.master-carton-code input"));

    public static Target MASTER_CARTON_UPC_IMAGE = Target.the("Master Carton UPC Image")
            .located(By.cssSelector("div.master-carton-image-attributes input"));

    public static Target CASE_IMAGE_VALUE = Target.the("The case upc image")
            .located(By.xpath("//div[contains(@class,'case-upc-image')]//div[@class='image-file-input']//div[contains(@class,'image') and (contains(@style,'no_image') or contains(@style,'null'))]"));

    public static Target STORAGE_FIELD = Target.the("The storage field")
            .located(By.cssSelector("div.storage-shelf-life-attributes input"));

    public static Target STORAGE_CONDITION = Target.the("The storage field condition")
            .located(By.xpath("(//div[contains(@class,'storage-shelf-life-attributes')]//input)[2]"));

    public static Target RETAIL_CONDITION = Target.the("The storage field condition")
            .located(By.xpath("(//div[contains(@class,'retail-shelf-life-attributes')]//input)[2]"));

    public static Target RETAIL_FIELD = Target.the("The retail field")
            .located(By.cssSelector("div.retail-shelf-life-attributes input"));

    public static Target MIN_TEMPERATURE_FIELD = Target.the("The min temperature field")
            .located(By.cssSelector("div.min-temperature input"));

    public static Target MAX_TEMPERATURE_FIELD = Target.the("The max temperature field")
            .located(By.cssSelector("div.max-temperature input"));

    public static Target CITY_FIELD = Target.the("The city field")
            .located(By.cssSelector(".manufacturer-address-attributes-city.el-input.el-input--small input"));

    public static Target COUNTRY_FIELD = Target.the("The country field")
            .located(By.cssSelector("select manufacturer-address-attributes-city"));

    public static Target STATE_ADDRESS_FIELD = Target.the("The state address field")
            .located(By.cssSelector("div.manufacturer-address-attributes-state input"));

    public static Target MICHIGAN_STATE = Target.the("The Michigan state")
            .located(By.cssSelector("div.popper-address-state-select li:nth-child(23)"));

    public static String STAGE_OPTION = "//li/span[text()='%s']";

    public static Target LEAD_TIME_FIELD = Target.the("The lead time field")
            .located(By.cssSelector("div.lead-time input"));

    public static Target INGREDIENTS_FIELD = Target.the("The ingredients field")
            .located(By.cssSelector("div.ingredients textarea"));

    public static Target DESCRIPTION_FIELD = Target.the("The description field")
            .located(By.cssSelector("div.description textarea"));

    public static Target ADD_NUTRITION_BUTTON = Target.the("The add nutrition button")
            .located(By.xpath("//span[contains(text(),'Add nutrition label')]"));

    public static Target NUTRITION_IMAGE = Target.the("The nutrition image")
            .located(By.xpath("//div[@class='nutrition-labels']//input"));

    public static Target LOW_QUANTITY_THRESHOLD = Target.the("The low quantity threshold")
            .located(By.xpath("//label[normalize-space()='Low quantity threshold']/following-sibling::div//input"));

    public static Target NUTRITION_IMAGE(int i) {
        return Target.the("The nutrition image")
                .located(By.xpath("(//div[@class='nutrition-labels']//input)[" + i + "]"));
    }

    public static Target NO_NUTRITION_IMAGE(int i) {
        return Target.the("The nutrition image")
                .located(By.xpath("(//div[contains(@class,'nutrition-labels')]//div[@class='image-file-input']//div[contains(@class,'image') and (contains(@style,'no_image') or contains(@style,'null'))])[" + i + "]"));
    }

    public static Target NO_NUTRITION_IMAGE = Target.the("The nutrition image")
            .located(By.xpath("//div[contains(@class,'nutrition-labels')]//div[@class='image-file-input']//div[contains(@class,'image') and (contains(@style,'no_image') or contains(@style,'null'))]"));

    public static Target NO_NUTRITION_IMAGE2 = Target.the("The nutrition image")
            .located(By.xpath("(//div[contains(@class,'nutrition-labels')]//div[@class='image-file-input']//div[contains(@class,'image')])"));


    public static Target NUTRITION_IMAGE_DES(int i) {
        return Target.the("The nutrition image")
                .located(By.xpath("(//textarea[@placeholder='Description'])[" + i + "]"));
    }

    public static Target THE_SECOND_NUTRITION_IMAGE = Target.the("The second nutrition")
            .located(By.cssSelector("div.nutrition-labels >div:nth-child(2) .image-file-input input"));

    public static Target THE_DELETE_BUTTON_OF_THE_SECOND_NUTRITION = Target.the("The delete button of the second nutrition")
            .located(By.cssSelector("div.nutrition-labels >div:nth-child(2) button.el-button>span"));

    public static Target QUALITIES_VALUES(String name) {
        return Target.the("").locatedBy("//label/span/div[text()='" + name + "']");
    }

    public static Target QUALITIES_VALUES_CHECKED(String name) {
        return Target.the("").locatedBy("//label/span/div[text()='" + name + "']/ancestor::label");
    }

    public static Target DAIRY_FREE = Target.the("The Dairy-free")
            .located(By.cssSelector("div.qualities .el-checkbox:nth-child(5) .el-checkbox__input"));

    public static Target quality_VEGAN = Target.the("The Vegan")
            .located(By.cssSelector("div.qualities .el-checkbox:nth-child(21) .el-checkbox__input"));

    public static Target SUBMIT_BUTTON = Target.the("The Create button")
            .located(By.cssSelector("div.tr button.el-button--primary"));

    public static Target EXPIRY_DAY_THRESHOLD = Target.the("Expiry day threshold")
            .located(By.xpath("//label[text()='Expiry day threshold']/following-sibling::div//input"));

    public static Target ADD_A_REGION = Target.the("The Add a region button")
            .located(By.xpath("//span[contains(text(),'Add a region')]"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target NEW_YORK_REGION = Target.the("The new york region")
            .located(By.xpath("//body/ul/li[@data-region-id='53']"));

    public static String REGION_OPTION = "//ul[not(contains(@style,'display: none'))]/li[text()='%s']";

    public static Target REGION_OPTION(String name) {
        return Target.the("").locatedBy("//ul[not(contains(@style,'display: none'))]/li[text()='" + name + "']");
    }

    public static String AVAILABILITY_OPTION = "//div[contains(@style,'absolute')]//span[text()='%s']";

    public static Target POPUP_ACTIVATING_SKU = Target.the("Popup is showing")
            .locatedBy("div.el-message-box__message");

    public static Target OK_POPUP_ACTIVATING_SKU = Target.the("Click Ok in popup")
            .located(By.cssSelector("button.el-button.el-button--default.el-button--small.el-button--primary"));

    public static Target PROP_65 = Target.the("The prop 65")
            .located(By.cssSelector("div[aria-label='California Proposition 65 Compliance Checklist and Attestation from Brand Partners']"));

    public static Target PROP_65_OVERVIEW = Target.the("The prop 65 ")
            .located(By.xpath("//div[@class='instruction-text mb-2']"));

    public static Target Submit_PROP_65 = Target.the("The submit prop 65")
            .located(By.xpath("//button[@type='button']//span//span[contains(text(),'Submit')]"));

    public static Target GENERAL_PROP_65_TYPE = Target.the("The submit prop 65")
            .located(By.xpath("//div[@class='prop-65-item']"));


    public static Target GENERAL_PROP_65_ITEM = Target.the("The submit prop 65")
            .located(By.xpath("//div[@class='props-65-item']"));


    public static Target DYNAMIC_PROP65_INFO(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("//dt[normalize-space()='" + name + "']/following-sibling::dd"));
    }

    public static Target DEFAULT_PULL_THRESHOLD = Target.the("")
            .located(By.xpath("//label[normalize-space()='Pull threshold (days)']/following-sibling::div//div[@role='switch']"));

    public static Target UPDATE_BUTTON(String name) {
        return Target.the("Update button")
                .located(By.xpath("//button//span[contains(text(),'" + name + "')]"));
    }

    public static Target DYNAMIC_INPUT(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("(//label[normalize-space()=\"" + name + "\"]/following-sibling::div//input)[last()]"));
    }

    public static Target DYNAMIC_INPUT2(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("//label[normalize-space()='" + name + "']/following-sibling::div//input"));
    }

    public static Target REMOVE_REGION(String name) {
        return Target.the("REMOVE " + name)
                .located(By.xpath("//div[normalize-space()='" + name + "']//following-sibling::div//button"));
    }

    public static Target REMOVE_REGION_BUYERCOMPANY(String buyer, String region) {
        return Target.the("REMOVE " + region + " of buyer company " + buyer)
                .located(By.xpath("//div[contains(text(),'" + buyer + "')]/ancestor::tr/following-sibling::tr//span[@data-original-text='" + region + "']/parent::td/following-sibling::td/button"));
    }
}
