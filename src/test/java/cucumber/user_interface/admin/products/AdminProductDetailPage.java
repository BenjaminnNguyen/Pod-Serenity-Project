package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminProductDetailPage {
    public static Target PRODUCT_NAME = Target.the("PRODUCT_NAME").located(By.cssSelector("span.name"));
    public static Target BRAND_NAME = Target.the("Brand Name").located(By.cssSelector("div.link-tag.brand"));
    public static Target VENDOR_COMPANY = Target.the("VENDOR_COMPANY").located(By.cssSelector("div.link-tag.vendor-company"));
    public static Target TYPE_OF_PRODUCT = Target.the("TYPE_OF_PRODUCT").located(By.cssSelector("div.type"));
    public static Target SAMPLEABLE = Target.the("SAMPLEABLE").located(By.cssSelector("div.samplable >span span"));
    public static Target PACKAGE_SIZE = Target.the("PACKAGE_SIZE").located(By.cssSelector("span.package-size"));
    public static Target UNIT_LWH = Target.the("UNIT_LWH").located(By.cssSelector("div.unit-size"));
    public static Target UNIT_SIZE = Target.the("UNIT_SIZE").located(By.cssSelector("span.volume"));
    public static Target CASE_WEIGHT = Target.the("CASE_WEIGHT").located(By.cssSelector("span.case-weight"));
    public static Target CASE_LWH = Target.the("CASE_LWH").located(By.cssSelector("div.case-size"));
    public static Target MICRO_DESCRIPTION = Target.the("MICRO_DESCRIPTION").located(By.cssSelector(".micro-description"));
    public static Target ADDITIONAL_FEE = Target.the("ADDITIONAL_FEE").located(By.cssSelector("span.additional-fee"));
    public static Target TAXES = Target.the("TAXES").located(By.cssSelector("div.fees>span"));
    public static Target CATEGORIES_OF_PRODUCT = Target.the("CATEGORIES_OF_PRODUCT").located(By.cssSelector("div.categories >div"));
    public static Target NEW_YORK_MOQ = Target.the("NEW_YORK_MOQ").located(By.xpath("//span[@data-region-id=\"53\"]"));
    public static Target NORTH_CALIFORNIA_MOQ = Target.the("NORTH_CALIFORNIA_MOQ").located(By.xpath("//span[@data-region-id=\"25\"]"));
    public static Target SOUTH_CALIFORNIA_MOQ = Target.the("SOUTH_CALIFORNIA_MOQ").located(By.xpath("//span[@data-region-id=\"51\"]"));
    public static Target TEXAS_MOQ = Target.the("TEXAS_MOQ").located(By.xpath("//span[@data-region-id=\"51\"]"));
    public static Target CHICAGO_MOQ = Target.the("CHICAGO_MOQ").located(By.xpath("//span[@data-region-id=\"26\"]"));
    public static Target EAST_MOQ = Target.the("NORTHEAST_MOQ").located(By.xpath("//span[@data-region-id=\"55\"]"));
    public static Target CENTRAL_MOQ = Target.the("MIDWEST_MOQ").located(By.xpath("//span[@data-region-id=\"58\"]"));
    public static Target SOUTHEAST_MOQ = Target.the("SOUTHEAST_MOQ").located(By.xpath("//span[@data-region-id=\"59\"]"));
    public static Target SOUTHWEST_AND_ROCKIES_MOQ = Target.the("SOUTHWEST_AND_ROCKIES_MOQ").located(By.xpath("//span[@data-region-id=\"60\"]"));
    public static Target WEST_MOQ = Target.the("WEST_MOQ").located(By.xpath("//span[@data-region-id=\"54\"]"));
    public static Target FLORIDA_EXPRESS_MOQ = Target.the("FLORIDA_EXPRESS_MOQ").located(By.xpath("//span[@data-region-id=\"54\"]"));
    public static Target MID_ATLANTIC_EXPRESS_MOQ = Target.the("MID_ATLANTIC_EXPRESS_MOQ").located(By.xpath("//span[@data-region-id=\"54\"]"));
    public static Target INACTIVE_SKU_NAME = Target.the("INACTIVE_SKU_NAME").located(By.cssSelector("#pane-inactived .variants >div .variant .name"));
    public static Target CURRENT_TAGS = Target.the("CURRENT_TAGS").located(By.cssSelector("div.tags span.product-tag-stamp:nth-child(1)"));
    public static Target UNITS_OF_ACTIVE_SKU = Target.the("UNITS_OF_ACTIVE_SKU").located(By.cssSelector("#pane-actived div.el-row:nth-child(1) div.case-units"));
    public static Target DELETE_BUTTON = Target.the("DELETE_BUTTON").located(By.xpath("//button[contains(@class,'el-button el-button--danger')]"));
    public static Target STATE_STATUS = Target.the("STATE_STATUS").located(By.xpath("//div[@class='status-tag']"));
    public static Target CASE_PER_PALLET = Target.the("CASE_PER_PALLET").located(By.xpath("//span[@class='case-pallet']"));
    public static Target CASE_PER_LAYER = Target.the("CASE_PER_LAYER").located(By.xpath("//span[@class='case-layer']"));
    public static Target LAYER_PER_PALLET = Target.the("LAYER_PER_PALLET").located(By.xpath("//span[@class='layer-pallet']"));
    public static Target MASTER_CARTON_PER_PALLET = Target.the("MASTER_CARTON_PER_PALLET").located(By.xpath("//span[@class='master-carton-per-pallet']"));
    public static Target CASE_PER_MASTER_CARTON = Target.the("CASE_PER_MASTER_CARTON").located(By.xpath("//span[@class='cases-per-master-carton']"));
    public static Target MASTER_CASE_WEIGHT = Target.the("MASTER_CASE_WEIGHT").located(By.xpath("//dt[normalize-space()='Master carton weight']/following-sibling::dd//span[@class='case-weight']"));
    public static Target MASTER_CASE = Target.the("MASTER_CASE").located(By.xpath("//dt[normalize-space()='Master carton L\" × W\" × H\"']/following-sibling::dd//div[@class='sizes-stamp unit-size']"));
    public static Target STATE_FEES = Target.the("STATE_FEES").located(By.xpath("//div[@class='fees']"));
    public static Target IS_BEVERAGE = Target.the("IS_BEVERAGE").located(By.xpath("//div[@class='boolean-stamp is-beverage']"));
    public static Target IS_BEVERAGE_INPUT_TOOLTIP = Target.the("IS_BEVERAGE").located(By.xpath("//div[@class='product-category-container-group']//input"));
    public static Target CONTAINER_TYPE_INPUT_TOOLTIP = Target.the("CONTAINER_TYPE_INPUT_TOOLTIP").located(By.xpath("(//div[@class='product-category-container-group']//input)[2]"));
    public static Target CONTAINER_TYPE = Target.the("CONTAINER_TYPE").located(By.xpath("//span[@class='product-container-type']"));

    public static Target CASE_PACK_PHOTO(String type, int i) {
        return Target.the("CASE_PACK_PHOTO")
                .located(By.xpath("(//div[normalize-space()='" + type + "']/following-sibling::section//div[@class='choose ellipsis'])[" + i + "]"));

    }

    public static Target REMOVE_MASTER_CASE_PHOTO(String type, String file) {
        return Target.the("CASE_PACK_PHOTO")
                .located(By.xpath("//div[normalize-space()='" + type + "']/following-sibling::section//div[contains(text(),'" + file + "')]/ancestor::div[@class='item']//button"));
    }

    public static Target SAVE_MASTER_CASE_PHOTO(String type) {
        return Target.the("CASE_PACK_PHOTO")
                .located(By.xpath("//div[normalize-space()='" + type + "']/following-sibling::div//button//span[text()='Save']"));
    }
/*
State fee popup
* */

    public static Target STATE_FEE_COMBOBOX(int i) {
        return Target.the("")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder])[" + i + "]");
    }

    public static Target STATE_FEE_VALUE(int i) {
        return Target.the("")
                .locatedBy("(//div[contains(@class,'fee_price_cents ')]//input)[" + i + "]");
    }

    public static Target STATE_FEE_DELETE(int i) {
        return Target.the("")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='el-row']//button)[" + i + "]");
    }

    public static Target STATE_FEE_DROPDOWN(String name) {
        return Target.the("")
                .locatedBy("//div[@class='el-select-dropdown el-popper popper-fee-select' and not( contains(@style,'display: none'))]//li[@class='el-select-dropdown__item']//span[contains(text(),'" + name + "')]");
    }

    public static Target STATE_FEE_COMBOBOX_LAST = Target.the("")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder])[last()]"));

    public static Target STATE_FEE_VALUE_LAST = Target.the("")
            .located(By.xpath("(//div[@class='el-row']/div[2]//input)[last()]"));

    public static Target ADD_STATE_FEE_BUTTON = Target.the("")
            .located(By.xpath("//span[contains(text(),'Add a state fee')]"));

    public static Target ADD_STATE_FEE_UPDATE_BUTTON = Target.the("")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//button[@type='button'][normalize-space()='Update'])"));

    public static Target STATE_FEE_COMBOBOX = Target.the("")
            .located(By.xpath("//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder]"));


    /*
Tags popup
* */

    public static Target TAGS_COMBOBOX = Target.the("")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder]");

    public static Target TAGS_EXPIRYDATE(String i) {
        return Target.the("")
                .locatedBy("//div[text()='" + i + "']/ancestor::div[@class='tag']//input[@placeholder='Select expiry date']");
    }


    //    Target ACTIVE_SKU_NAME = Target.the("").located(By.cssSelector("#pane-actived div.el-row:nth-child(1) div.variant a.name"));
    public static Target ACTIVE_SKU_NAME = Target.the("The active sku name")
            .located(By.cssSelector("#pane-actived .el-row .name"));

    public static Target DYNAMIC_INFO(String s) {
        return Target.the("").locatedBy("//span[contains(@class,'" + s + "')]");
    }

    public static Target NAME_OF_AN_SKU(String skuName) {
        return Target.the("skuName").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//div[@class='variant']/a[contains(text(),'%s')]", skuName));
    }

    public static Target UNIT_UPC_OF_AN_SKU(String skuName) {
        return Target.the("unit upc of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//div[@class='variant']/a[contains(text(),'%s')]/preceding-sibling::span//span[contains(@class,'unit')]", skuName));
    }

    public static Target CASE_UPC_OF_AN_SKU(String skuName) {
        return Target.the("case up of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//div[@class='variant']/a[contains(text(),'%s')]/preceding-sibling::span//span[contains(@class,'case')]", skuName));
    }

    public static Target STATUS_OF_AN_SKU(String skuName) {
        return Target.the("status of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'%s')]/ancestor::div[@class='el-row']//div[@class='status-tag']", skuName));
    }

    public static Target UNIT_PER_OF_AN_SKU(String skuName) {
        return Target.the("unit per of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'%s')]/parent::div/following-sibling::div[contains(@class,'case-units')]", skuName));
    }

    public static Target CODE_OF_AN_SKU(String skuName) {
        return Target.the("code of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'%s')]/following-sibling::div/span", skuName));
    }

    public static Target REGIONS_OF_AN_SKU(String skuName) {
        return Target.the("region of sku").locatedBy(String.format("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'%s')]/ancestor::div[@class='el-row']/div[3]//ul[@class='regions']", skuName));
    }

    public static Target TAGS_OF_AN_SKU(String skuName, String tag) {
        return Target.the("tags of sku").locatedBy("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'" + skuName + "')]/ancestor::div[@class='el-row']//div[@class='tags']//span[@class='name' and contains(text(),'" + tag + "')]");
    }

    public static Target TAGS_EXPIRY_OF_AN_SKU(String skuName, String tag) {
        return Target.the("tags of sku").locatedBy("//div[@role='tabpanel' and not(@style='display: none;')]//a[contains(text(),'" + skuName + "')]/ancestor::div[@class='el-row']//div[@class='tags']//span[@class='name' and contains(text(),'" + tag + "')]/following-sibling::span//span[@class='date']");
    }

    public static Target TAB_SKU(String tap) {
        return Target.the("tap " + tap).locatedBy("//div[contains(@id,'" + tap + "')]");
    }

    public static Target DUPLICATE_ON_DETAIL = Target.the("Button duplicate").locatedBy("//button[contains(@class,'duplicate-btn')]");


    public static Target DUPLICATE(String st) {
        return Target.the("Duplicate button")
                .locatedBy("//*[text()='" + st + "']//ancestor::tr/td[contains(@class,'actions')]//*[contains(@data-icon,'copy')]");
    }

    public static String NAME_OF_AN_SKU = "//div[@class='variant']/a[text()='%s']";
    public static String UNIT_UPC_OF_AN_SKU = "//div[@class='variant']/a[text()='%s']/preceding-sibling::span/span[contains(@class,'unit')]";
    public static String CASE_UPC_OF_AN_SKU = "//div[@class='variant']/a[text()='%s']/preceding-sibling::span/span[contains(@class,'case')]";
    public static String STATUS_OF_AN_SKU = "//a[normalize-space()='%s']/ancestor::div[@class='el-row']//div[@class='status-tag']";

    // [SKU LINE]

    public static Target ADD_NEW_SKU_BUTTON = Target.the("Add New SKU button")
            .located(By.xpath("//span[contains(text(), 'Add new SKU')]"));

    public static Target DUPLICATE_SKU_BUTTON = Target.the("Add New SKU button")
            .located(By.xpath("//a[contains(text(),'Copy of sku random0805022649')]/ancestor::div[@class='variant']/parent::div/following-sibling::div/button[1]"));

    public static Target DUPLICATE_SKU_BUTTON(String sku) {
        return Target.the("Inactivate tab")
                .located(By.xpath("//a[contains(text(),'" + sku + "')]/ancestor::div[@class='variant']/parent::div/following-sibling::div/button[1]"));
    }

    public static Target SKU_TAB(String tab) {
        return Target.the("Inactivate tab")
                .located(By.xpath("//div[contains(@id,'" + tab + "')]"));
    }

    public static Target DRAFT_TAB = Target.the("The Draft tab")
            .located(By.cssSelector("#tab-drafted"));

    public static Target ACTIVE_TAB = Target.the("The active tab")
            .located(By.cssSelector("#tab-actived"));

    public static Target ACTIVATE_THIS_PRODUCT_BUTTON = Target.the("The Activate this product button")
            .located(By.xpath("//span[contains(text(), 'Activate this product')]"));


    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target DESCRIPTION_FIELD = Target.the("The description field")
            .located(By.cssSelector("div.description textarea"));

    public static Target ADD_NUTRITION_BUTTON = Target.the("The add nutrition button")
            .located(By.xpath("//span[contains(text(),'Add nutrition label')]"));


    public static Target ACTIVE_BY_REGION(String region) {
        return Target.the("Active of region " + region)
                .locatedBy("//div[text()='" + region + "']/parent::div/following-sibling::div//span[text()='Active']");
    }

    public static Target ACTIVE_BY_REGION_STATUS(String region) {
        return Target.the("Status active of region " + region)
                .locatedBy("//div[text()='" + region + "']/parent::div/following-sibling::div//input");
    }

    public static Target AVAILABILITY_TEXTBOX(String region) {
        return Target.the("Availability textbox by region " + region)
                .locatedBy("//div[text()='" + region + "']/ancestor::div//div[@select-class='select-region-availabitity-1']//input");
    }

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@style,'absolute')]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target EDIT_REGION_MOQ(String value) {
        return Target.the(value)
                .located(By.xpath("//dt[normalize-space()='" + value + "']/following-sibling::dd[@class='moq']//span[@class='el-popover__reference-wrapper']"));
    }

    /**
     * Mass editing
     */

    public static Target MASS_EDIT_SKU_CHECKBOX(String value) {
        return Target.the(value)
                .located(By.xpath("//span[contains(@data-original-text,'" + value + "')]/ancestor::td/preceding-sibling::td[@class='checkbox']//span"));
    }

    public static Target MASS_EDIT_SKU_NAME(String name, String clas) {
        return Target.the(name)
                .located(By.xpath("//*[contains(text(),'" + name + "')]/ancestor::div[@class='sku']//*[contains(@class,'" + clas + "')]"));
    }

    public static Target MASS_EDIT_END_QTY(String name) {
        return Target.the(name)
                .located(By.xpath("//div[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td"));
    }

    public static Target MASS_EDIT_END_QTY(String region, String name) {
        return Target.the(name)
                .located(By.xpath("//tbody//span[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td[count(//table[@class='skus-table']//span[@data-original-text='" + region + "']/parent::th/preceding-sibling::th)-1]"));
    }

    public static Target MASS_EDIT_ALL_SKU = Target.the("")
            .located(By.xpath("//th[@class='check-all']"));

    public static Target MASS_EXPIRY_DATE_TEXTBOX(String skuName) {
        return Target.the("Expiry date textbox of SKU " + skuName)
                .located(By.xpath("//span[contains(text(),'" + skuName + "')]//ancestor::td/following-sibling::td//input"));
    }

    public static Target MASS_EXPIRY_DATE_DELETE_BUTTON(String skuName) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//span[contains(text(),'" + skuName + "')]//ancestor::td/following-sibling::td//div[@class='actions']"));
    }

    public static Target MASS_REGION_INFO(String skuName, String region) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-regions']//span[contains(text(),'" + skuName + "')]/ancestor::tbody/tr[@class='sub-item']/td[1]//span[text()='" + region + "']/preceding-sibling::div"));

    }

    public static Target MASS_REGION_INVENTORY_COUNT(String skuName, String region) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-regions']//span[contains(text(),'" + skuName + "')]/ancestor::tbody/tr[@class='sub-item']/td[1]//span[text()='" + region + "']/parent::td/following-sibling::td[1]"));

    }

    public static Target MASS_REGION_CASE_PRICE(String skuName, String region) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-regions']//span[contains(text(),'" + skuName + "')]/ancestor::tbody/tr[@class='sub-item']/td[1]//span[text()='" + region + "']/parent::td/following-sibling::td[2]//input"));

    }

    public static Target MASS_BUYER_CASE_PRICE(String skuName, String buyerCompany, String region, String field) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-buyers']//span[contains(text(),'" + skuName + "')]//ancestor::tbody//span[contains(text(),'" + buyerCompany + "')]/parent::td/following-sibling::td//span[text()='" + region + "']/ancestor::tr/td//*[contains(@class,'" + field + "')]//input"));
    }

    public static Target MASS_BUYER_INVENTORY_COUNT(String skuName, String buyerCompany, String region, String field) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-buyers']//span[contains(text(),'" + skuName + "')]//ancestor::tbody//span[contains(text(),'" + buyerCompany + "')]/parent::td/following-sibling::td//span[text()='" + region + "']/ancestor::tr/td//*[contains(@class,'" + field + "')]"));
    }

    public static Target MASS_STORE_INVENTORY_COUNT(String skuName, String store, String region, String field) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-stores']//span[contains(text(),'" + skuName + "')]//ancestor::tbody//*[contains(text(),'" + store + "')]/ancestor::tr/td//span[text()='" + region + "']/ancestor::tr/td//*[contains(@class,'" + field + "')]"));
    }

    public static Target MASS_STORE_CASE_PRICE(String skuName, String store, String region, String field) {
        return Target.the("Expiry date delete button of SKU " + skuName)
                .located(By.xpath("//div[@id='pane-stores']//span[contains(text(),'" + skuName + "')]//ancestor::tbody//*[contains(text(),'" + store + "')]/ancestor::tr/td//span[text()='" + region + "']/ancestor::tr/td//*[contains(@class,'" + field + "')]//input"));
    }

}

