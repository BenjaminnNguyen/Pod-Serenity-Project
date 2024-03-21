package cucumber.user_interface.beta.Vendor.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorCreateNewSKUPage {
    ///Alpha page
    public static Target SKUS_TAP = Target.the("SKUs tap")
            .located(By.xpath("//a[normalize-space()='SKUs']"));
    public static Target PAGE_TITLE = Target.the("PAGE_TITLE")
            .locatedBy(".page__title");

    public static Target CREATE_YOUR_FIRST_SKU(String field) {
        return Target.the("CREATE_YOUR_FIRST_SKU")
                .locatedBy("//div[normalize-space()='" + field + "']/ancestor::label");
    }

    public static Target PAGE_INFO = Target.the("PAGE_INFO")
            .locatedBy("//div[@class='sub-header' and text()='Price, MSRP, and inventory availability need to be set up before SKU is published.']");

    public static Target SKU_INFO = Target.the("SKU_INFO")
            .locatedBy("//a[normalize-space()='< Manage SKU info']");

    public static Target REGION_TAP = Target.the("REGION tap")
            .located(By.xpath("//strong[normalize-space()='Region-Specific']"));

    public static Target BUYER_COMPANY_SPECIFIC_TAP = Target.the("BUYER_COMPANY_SPECIFIC_TAP ")
            .located(By.xpath("//strong[normalize-space()='Buyer-Company-Specific Price']"));

    public static Target DYNAMIC_SKU_TAB(String field) {
        return Target.the("Field " + field)
                .located(By.xpath("//strong[normalize-space()='" + field + "']"));
    }

    public static Target STATUS_REGION_SKU(String region) {
        return Target.the("Region " + region)
                .located(By.xpath("//strong[normalize-space()='" + region + "']/preceding-sibling::div"));
    }

    public static Target STATUS_REGION_SKU2(String region) {
        return Target.the("Region " + region)
                .located(By.xpath("//strong[normalize-space()='" + region + "']/preceding-sibling::div/span"));
    }

    public static Target NEW_SKU_BUTTON = Target.the("New SKU button")
            .located(By.xpath("//span[normalize-space()='Create new SKU']"));

    public static Target SKU_NAME = Target.the("Sku name")
            .located(By.xpath("//label[normalize-space()='Name']/following-sibling::div//input"));

    public static Target BARCODE_TYPE = Target.the("Barcodes Type")
            .located(By.xpath("//label[normalize-space()='Barcodes Type']/following-sibling::div//div[@class='value']"));

    public static Target BARCODE_TYPE2 = Target.the("Barcodes Type")
            .located(By.xpath("//label[normalize-space()='Barcodes Type']/following-sibling::div//input"));

    public static Target BARCODE_TYPE_DISABLE = Target.the("Barcodes Type")
            .located(By.xpath("//div[@class='simulate-disabled-input']"));

    public static Target DYNAMIC_FIELD(String field) {
        return Target.the("Field " + field)
                .located(By.xpath("//label[normalize-space()='" + field + "']/following-sibling::div//input|//label[normalize-space()='" + field + "']/following-sibling::div//textarea"));
    }

    public static Target DYNAMIC_FIELD_AREA(String field) {
        return Target.the("Field " + field)
                .located(By.xpath("//label[normalize-space()='" + field + "']/following-sibling::div//textarea"));
    }

    public static Target MAIN_SKU = Target.the("Main sku")
            .located(By.xpath("//span[contains(text(),'Main SKU')]/ancestor::label[contains(@class,'el-checkbox')]"));

    public static Target SKU_IMAGE = Target.the("SKU Image")
            .located(By.xpath("//div[text()='SKU Image']//ancestor::label/following-sibling::div//input"));

    public static Target INGREDIENTS = Target.the("Ingredients")
            .located(By.xpath("//label[normalize-space()='Ingredients']/following-sibling::div//textarea"));

    public static Target DESCRIPTION = Target.the("Description")
            .located(By.xpath("//label[normalize-space()='Description']/following-sibling::div//textarea"));

    public static Target LEAD_TIME = Target.the("Lead time")
            .located(By.xpath("//label[normalize-space()='Lead time']/following-sibling::div//input"));

    public static Target UNITS_CASE = Target.the("Units/case")
            .located(By.xpath("//label[normalize-space()='Units/case']/following-sibling::div//input"));

    public static Target BAR_CODES_TYPE = Target.the("Barcodes Type")
            .located(By.xpath("//label[normalize-space()='Barcodes Type']/following-sibling::div//input"));

    public static Target BAR_CODES_TYPE_UPC = Target.the("Barcodes Type UPC")
            .located(By.xpath("//div[@class='el-scrollbar']//span[normalize-space()='UPC']"));

    public static Target BAR_CODES_TYPE_EAN = Target.the("Barcodes EAN")
            .located(By.xpath("//div[@class='el-scrollbar']//span[normalize-space()='EAN']"));

    public static Target UNITS_UPC_IMAGE = Target.the("Unit UPC Image")
            .located(By.xpath("//div[text()='Unit UPC Image']//ancestor::label/following-sibling::div//input"));

    public static Target CASE_UPC_IMAGE = Target.the("Case UPC Image")
            .located(By.xpath("//div[text()='Case UPC Image']//ancestor::label/following-sibling::div//input"));

    public static Target UNITS_EAN_IMAGE = Target.the("Unit EAN Image")
            .located(By.xpath("//div[text()='Unit EAN Image']//ancestor::label/following-sibling::div//input"));

    public static Target CASE_EAN_IMAGE = Target.the("Case EAN Image")
            .located(By.xpath("//div[text()='Case EAN Image']//ancestor::label/following-sibling::div//input"));

    public static Target MASTER_CARTON_UPC_IMAGE = Target.the("MASTER_CARTON_UPC_IMAGE")
            .located(By.xpath("//span[text()='Master Carton UPC Image']//ancestor::label/following-sibling::div//input"));

    public static Target MASTER_CARTON_EAN_IMAGE = Target.the("MASTER_CARTON_EAN_IMAGE")
            .located(By.xpath("//span[text()='Master Carton EAN Image']//ancestor::label/following-sibling::div//input"));

    public static Target UNIT_UPC_INPUT = Target.the("'Unit UPC")
            .located(By.xpath("//span[text()='Unit UPC']/parent::label/following-sibling::div//input"));

    public static Target CASE_UPC_INPUT = Target.the("Case UPC")
            .located(By.xpath("//span[text()='Case UPC']/parent::label/following-sibling::div//input"));

    public static Target UNIT_EAN_INPUT = Target.the("Unit EAN")
            .located(By.xpath("//span[text()='Unit EAN']/parent::label/following-sibling::div//input"));

    public static Target CASE_EAN_INPUT = Target.the("Case EAN")
            .located(By.xpath("//span[text()='Case EAN']/parent::label/following-sibling::div//input"));

    public static Target COUNTRY_INPUT = Target.the("Country")
            .located(By.xpath("//*[text()='Country']/following-sibling::div//input"));

    public static Target COUNTRY = Target.the("Country")
            .located(By.xpath("//*[text()='Country']/following-sibling::div"));

    public static Target CITY_INPUT = Target.the("City")
            .located(By.xpath("//*[text()='City']/following-sibling::div//input"));

    public static Target COUNTRY_US = Target.the("COUNTRY U.S")
            .located(By.xpath("//div[@class='el-scrollbar']//span[normalize-space()='U.S']"));

    public static Target COUNTRY_CANADA = Target.the("COUNTRY U.S")
            .located(By.xpath("//div[@class='el-scrollbar']//span[normalize-space()='Canada']"));

    public static Target STAGE_INPUT = Target.the("State (Province/Territory")
            .located(By.xpath("//*[text()='State (Province/Territory)']/following-sibling::div//input"));

    public static String STAGE_VALUES = "//div[@class='el-scrollbar']//span[normalize-space()='%s']";

    public static String QUALITIES_VALUES = "//div[@class='el-checkbox-group qualities-grid']//span[normalize-space()='%S']";

    public static Target STORAGE_SHELF_LIFE = Target.the("Storage shelf life (days)")
            .located(By.xpath("//span[text()='Storage shelf life (days)']/parent::label/following-sibling::div//input"));

    public static Target STORAGE_CONDITION = Target.the("Storage condition")
            .located(By.xpath("//*[text()='Storage condition']/following-sibling::div//input"));

    public static Target RETAIL_SHELF_LIFE = Target.the("Retail shelf life (days)")
            .located(By.xpath("//span[text()='Retail shelf life (days)']/parent::label/following-sibling::div//input"));

    public static Target RETAIL_CONDITION = Target.the("Retail condition")
            .located(By.xpath("//*[text()='Retail condition']/following-sibling::div//input"));

    public static Target CONDITION_VALUES(String val) {
        return Target.the("").locatedBy("(//div[@class='el-scrollbar']//span[normalize-space()='" + val + "'])[2]");
    }

    public static Target ADD_NUTRITION = Target.the("Add new nutrition")
            .located(By.cssSelector("button[class='el-button el-button--primary el-button--small']"));

    public static Target DELETE_NUTRITION(int i) {
        return Target.the("delete nutrition")
                .locatedBy("(//div[@class='actions']/button)[" + i + "]");
    }

    public static Target NUTRITION_IMAGE(int i) {
        return Target.the("delete nutrition")
                .locatedBy("(//div[@class='info']//div[@class='image'])[" + i + "]");
    }

    public static Target NUTRITION_DES(int i) {
        return Target.the("delete nutrition")
                .locatedBy("(//div[@class='info']//input[@type='text'])[" + i + "]");
    }

    public static Target NUTRITION_IMAGE = Target.the("NUTRITION_IMAGE")
            .located(By.xpath("(//div[@class='file-input']//input[@type='file'])[last()]"));

    public static Target NUTRITION_DES = Target.the("NUTRITION_IMAGE")
            .located(By.xpath("(//div[@class='inventory-image-card']//input[@placeholder='Description'])[last()]"));

    public static Target NEXT_BUTTON2 = Target.the("Retail condition")
            .located(By.xpath("//button/span[normalize-space()='Next']"));

    public static Target QUALITIES_CHECKBOX(String q) {
        return Target.the("QUALITIES_CHECKBOX " + q)
                .locatedBy("//span[normalize-space()='" + q + "']/parent::label[contains(@class,'el-checkbox')]");
    }

    public static Target REGION(String r) {
        return Target.the("REGION " + r)
                .locatedBy("(//ul//li[text()='" + r + "'])[last()]");
    }

    public static Target REGION_OPTION(String r) {
        return Target.the("REGION " + r)
                .locatedBy("//form[@class='el-form']//strong[normalize-space()='" + r + "']/preceding-sibling::div");
    }

    public static Target ADD_NEW_REGION = Target.the("ADD_NEW_REGION")
            .located(By.cssSelector("button[role='button']"));

    public static String WHOLESALE_PRICE = "//strong[normalize-space()='%s']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Wholesale price/CASE']/following-sibling::div//input";

    public static Target WHOLESALE_PRICE(String region) {
        return Target.the("").locatedBy("//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Wholesale price/CASE']/following-sibling::div//input");
    }

    public static Target SPECIFIC_PRICE(String region) {
        return Target.the("").locatedBy("//span[normalize-space()='" + region + "']/following-sibling::span[1]");
    }

    public static Target SPECIFIC_PRICE_AVAILABILITY(String region) {
        return Target.the("").locatedBy("//span[normalize-space()='" + region + "']/following-sibling::span[2]");
    }

    public static String MSRP_UNIT = "//strong[normalize-space()='%s']/ancestor::div[@class='el-row'][1]//label[normalize-space()='MSRP/unit']/following-sibling::div//input";

    public static Target MSRP_UNIT(String region) {
        return Target.the("").locatedBy("//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'][1]//label[normalize-space()='MSRP/unit']/following-sibling::div//input");
    }

    public static Target ARRIVING(String region) {
        return Target.the("ariving").locatedBy("//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Expected inventory date']/following-sibling::div//input");

    }

    public static String AVAILABILITY = "//strong[normalize-space()='%s']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Availability :']/following-sibling::div//span[contains(text(),'%s')]";

    public static Target AVAILABILITY(String region, String value) {
        return Target.the("AVAILABILITY OF " + region)
                .locatedBy("//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Availability :']/following-sibling::div//span[contains(text(),'" + value + "')]");

    }

    public static String AVAILABILITY_CHECKED = "(//strong[normalize-space()='%s']/ancestor::div[@class='el-row'])[3]//label[normalize-space()='Availability :']/following-sibling::div//label[@aria-checked='true']//span[text()='%s']";

    public static Target AVAILABILITY_CHECKED(String region, String value) {
        return Target.the("AVAILABILITY OF " + region)
                .locatedBy("//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'][1]//label[normalize-space()='Availability :']/following-sibling::div//label[@aria-checked='true']//span[text()='" + value + "']");

    }

    public static String EXPECTED_INVENTORY_DATE = "(//strong[normalize-space()='%s']/ancestor::div[@class='el-row'])[2]//label[normalize-space()='Expected inventory date']/following-sibling::div//input";

    public static Target EXPECTED_INVENTORY_DATE(String region) {
        return Target.the("")
                .locatedBy("(//strong[normalize-space()='" + region + "']/ancestor::div[@class='el-row'])[2]//label[normalize-space()='Expected inventory date']/following-sibling::div//input");

    }

    public static Target CONFIRM_TITLE = Target.the("Confirm Popup")
            .located(By.xpath("//div[@class='title']"));

    public static Target CONFIRM_SUB_TITLE = Target.the("Confirm Popup")
            .located(By.xpath("//div[@class='sub-title mb-2']"));

    public static Target CONFIRM_OPTION() {
        return Target.the("Confirm Popup")
                .located(By.xpath("//div[@class='sub-title mb-2']//label/span[2]"));
    }

    public static Target REMOVE_REGION(String region) {
        return Target.the("Confirm Popup")
                .located(By.xpath("//strong[normalize-space()='" + region + "']/ancestor::div[@class='flex']/following-sibling::button"));
    }

    public static Target ADD_CONFIRM = Target.the("The ADD confirm button")
            .located(By.xpath("//span[normalize-space()='Add']"));

    public static Target CONFIRM_OPTION = Target.the("Confirm option")
            .located(By.xpath("//span[@class='el-checkbox__label']//p"));

    public static Target PROP65_TITLE = Target.the("Prop 65 title")
            .located(By.xpath("//h3[contains(text(),'California Proposition 65 Compliance Checklist and')]"));

    public static Target PROP65_DES = Target.the("Prop 65 Description")
            .located(By.xpath("//div[@class='description']"));

    public static Target CHEMICALS_PROP_65 = Target.the("contain any chemicals on prop 65")
            .located(By.xpath("//span[contains(text(),'Prop. 65')]"));

    public static Target PUBLISH_BUTTON2 = Target.the("Publish button")
            .located(By.xpath("//*[contains(text(),'Publish')]"));

    public static Target CONTINUE_BUTTON2 = Target.the("The Continue button")
            .located(By.xpath("//span[normalize-space()='Continue']"));

    public static String REGION_OPTION = "//li[normalize-space()='%s']";

    public static Target ALERT_SUCCESS = Target.the("Alert message success")
            .located(By.xpath("//div[contains(@class,'el-message el-message--success')]"));
    public static Target MIN_TEMPERATURE = Target.the("Alert message success")
            .located(By.xpath("//label[normalize-space()='Min temperature (F)']/following-sibling::div//input"));
    public static Target MAX_TEMPERATURE = Target.the("Alert message success")
            .located(By.xpath("//label[normalize-space()='Max temperature (F)']/following-sibling::div//input"));

    public static Target DYNAMIC_INPUT(String field) {
        return Target.the("field " + field)
                .located(By.xpath("//label[normalize-space()='" + field + "']/following-sibling::div//input"));
    }

    public static Target DYNAMIC_INPUT2(String field) {
        return Target.the("field " + field)
                .located(By.xpath("//label[normalize-space()='" + field + "']//ancestor::label/following-sibling::div//input"));
    }

    public static Target REQUEST_INFO_CHANGE = Target.the("Request Product Change Button")
            .located(By.xpath("//div[@class='el-card__body']//span[text()='Request Product Change']"));

    // Request Information Change
    public static Target SKU_IN_REQUEST_CHANGE(String skuName) {
        return Target.the("Button SKU in Request Product Change")
                .located(By.xpath("//div[@class='skus-list']//div[text()='" + skuName + "']"));
    }

    public static Target PRICE_OF_REGION_SPECIFIC_TEXTBOX(String region) {
        return Target.the("Button SKU in Request information change")
                .located(By.xpath("//div[text()='" + region + "']/parent::div//input[@type='number']"));
    }

    public static Target REQUEST_NOTE_TEXTAREA = Target.the("Request Note Text area")
            .located(By.xpath("//div[text()='Request Note']/parent::div//input[@type='text']"));

    public static Target SUBMIT_REQUEST_BUTTON = Target.the("Submit request button")
            .located(By.xpath("//button//span[text()='Submit Request']"));

    public static Target CASE_PRICE_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer) {
        return Target.the("CASE_PRICE_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(CASE_PRICE_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static Target DYNAMIC_BUYER_SPECIFIC_FIELD(String field, String buyer, int region) {
        return Target.the("")
                .locatedBy("(//div[contains(text(),'" + buyer + "')]/../../div//label[text()='" + field + "']/following-sibling::div//input)[" + region + "]");
    }

    public static Target DYNAMIC_BUYER_SPECIFIC_FIELD(String field, String buyer, String region) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + buyer + "')]/../../div//span[normalize-space()='" + region + "']/../../following-sibling::div//label[text()='" + field + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_STORE_SPECIFIC_FIELD(String field, String region) {
        return Target.the("")
                .locatedBy("//strong[normalize-space()='" + region + "']/parent::div/following-sibling::div//label[text()='" + field + "']/following-sibling::div//input");
    }

    public static Target STORE_SPECIFIC_FIELD(String region) {
        return Target.the("")
                .locatedBy("//strong[normalize-space()='" + region + "']/parent::div/following-sibling::div//label[text()='Store']/following-sibling::div//textarea");
    }

    public static Target STORE_SPECIFIC_FIELD2(String region) {
        return Target.the("")
                .locatedBy("//strong[normalize-space()='" + region + "']/parent::div/following-sibling::div//label[text()='Store']/following-sibling::div//textarea");
    }

    public static Target USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer) {
        return Target.the("USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static Target USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer, int region) {
        return Target.the("USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static Target START_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer) {
        return Target.the("START_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(START_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static Target END_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer) {
        return Target.the("END_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(END_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static Target AVAILABILITY_ON_BUYER_COMPANY_SPECIFIC_TAP(String buyer) {
        return Target.the("AVAILABILITY_ON_BUYER_COMPANY_SPECIFIC_TAP").locatedBy(String.format(AVAILABILITY_ON_BUYER_COMPANY_SPECIFIC_TAP, buyer));
    }

    public static String CASE_PRICE_ON_BUYER_COMPANY_SPECIFIC_TAP = "//div[contains(text(),'%s')]/../../div//label[text()='Case Price']/following-sibling::div//input";
    public static String USRP_UNIT_ON_BUYER_COMPANY_SPECIFIC_TAP = "//div[contains(text(),'%s')]/../../div//label[text()='MSRP/unit']/following-sibling::div//input";
    public static String START_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP = "//div[contains(text(),'%s')]/../../div//label[text()='Start date']/following-sibling::div//input";
    public static String END_DATE_ON_BUYER_COMPANY_SPECIFIC_TAP = "//div[contains(text(),'%s')]/../../div//label[text()='End date']/following-sibling::div//input";
    public static String AVAILABILITY_ON_BUYER_COMPANY_SPECIFIC_TAP = "//div[contains(text(),'%s')]/../../div//label[text()='Availability']/following-sibling::div//input";


    public static Target GENERAL_PROP_65_TITLE = Target.the("The title prop 65")
            .located(By.xpath("//strong[contains(text(),'California Proposition 65 Compliance Checklist and Attestation from Brand Partners')]"));


    public static Target GENERAL_PROP_65_TYPE = Target.the("The title prop 65")
            .located(By.xpath("//ul[contains(@class,'prop65-card')]//*[contains(text(),'The referenced product contains one or more chemicals on the Prop. 65 List, as identified below.')]"));

    public static Target PRODUCT_IMAGE_ON_SKU = Target.the("PRODUCT_IMAGE_ON_SKU")
            .located(By.xpath("//div[@class='product-card']//div[@class='image']"));

    public static Target GENERAL_PROP_65_TYPE(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("//ul[contains(@class,'prop65-card')]//*[contains(text(),'" + name + "')]"));
    }

    public static Target DYNAMIC_IMAGE(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("//span[normalize-space()='" + name + "']/parent::label/following-sibling::div//div[@class='content']/div"));
    }

    public static Target GENERAL_PROP_65_ITEM = Target.the("The submit prop 65")
            .located(By.xpath("//div[@class='props-65-item']"));


    public static Target DYNAMIC_PROP65_INFO(String name) {
        return Target.the("INPUT " + name)
                .located(By.xpath("//ul[contains(@class,'prop65-card')]//*[contains(text(),'" + name + "')]/strong"));
    }

    public static Target BACK = Target.the("Back")
            .located(By.cssSelector(".linked.nuxt-link-active"));


}
