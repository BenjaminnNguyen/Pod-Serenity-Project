package cucumber.user_interface.beta.Vendor.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorCreateProductPage {

    public static Target DYNAMIC_FIELD(String field) {
        return Target.the("Product Name field")
                .located(By.xpath("//*[normalize-space()='" + field + "']/following-sibling::div//input"));
    }

    public static Target PRODUCT_TITLE = Target.the("Product Name field")
            .located(By.xpath("//*[normalize-space()='Product']/following-sibling::div//input"));

    public static Target BRANDS_INPUT = Target.the("Brand List")
            .located(By.xpath("//label[normalize-space()='Brand']/following-sibling::div//input"));

    public static Target BRANDS_LIST(String value) {
        return Target.the("Brands item in dropdown").located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target CATEGORY_INPUT = Target.the("Category list")
            .located(By.xpath("//label[normalize-space()='Category']/following-sibling::div//input"));

    public static Target CATEGORY_LIST(String value) {
        return Target.the("Category item in dropdown").located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target PRODUCT_TYPE_INPUT = Target.the("Product type list")
            .located(By.xpath("//label[normalize-space()='Product type']/following-sibling::div//input"));

    public static Target PRODUCT_TYPE_LIST(String value) {
        return Target.the("Product type item").located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target REQUEST_SAMPLE_BOX = Target.the("Sample request")
            .located(By.xpath("//span[text()='Allow stores to request samples']"));
    public static Target REQUEST_SAMPLE_LABEL = Target.the("Sample request")
            .located(By.xpath("//span[text()='Allow stores to request samples']/ancestor::label"));

    public static Target UNIT_LENGTH_FIELD = Target.the("Unit Length field")
            .located(By.xpath("(//input[@type='number'])[1]"));

    public static Target UNIT_WIDTH_FIELD = Target.the("Unit Width field")
            .located(By.xpath("(//input[@type='number'])[2]"));

    public static Target UNIT_HEIGHT_FIELD = Target.the("Unit Height field")
            .located(By.xpath("(//input[@type='number'])[3]"));

    public static Target CASE_LENGTH_FIELD = Target.the("Case Length field")
            .located(By.xpath("(//input[@type='number'])[4]"));

    public static Target CASE_WIDTH_FIELD = Target.the("Case Width field")
            .located(By.xpath("(//input[@type='number'])[5]"));

    public static Target CASE_HEIGHT_FIELD = Target.the("Case Height field")
            .located(By.xpath("(//input[@type='number'])[6]"));

    public static Target PACKAGE_SIZE_INPUT = Target.the("Package size field")
            .located(By.xpath("//label[normalize-space()='Package size']/following-sibling::div//input"));

    public static Target PACKAGE_SIZE_LIST(String value) {
        return Target.the("PACKAGE_SIZE_LIST field")
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target UNIT_SIZE_FIELD = Target.the("Unit Size field")
            .located(By.xpath("(//input[@type='number'])[8]"));

    public static Target CASE_WEIGHT_FIELD = Target.the("CASE WEIGHT FIELD")
            .located(By.xpath("(//input[@type='number'])[7]"));

    public static Target UNIT_INPUT = Target.the("Unit field")
            .located(By.xpath("//label[normalize-space()='Unit']/following-sibling::div//input"));

    public static Target UNIT_LIST(String value) {
        return Target.the("Unit list item")
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target IS_BEVERAGE(String value) {
        return Target.the("The product IS_BEVERAGE field")
                .located(By.xpath("//*[normalize-space()='Is this a beverage?']/following-sibling::div//span[text()='" + value + "']/parent::label"));

    }
    public static Target BOTTLE_DEPOSIT_LABEL = Target.the("The product BOTTLE_DEPOSIT_LABEL field")
                .located(By.xpath("//label[@for='bottle_deposit_label_image_attributes']/following-sibling::div//input[@accept='image/png,image/jpeg,image/gif']"));

    public static Target BOTTLE_DEPOSIT_LABEL_HELP = Target.the("The product IS_BEVERAGE field")
                .located(By.xpath("//span[@class='help-tag el-popover__reference']"));

    public static Target BOTTLE_DEPOSIT_LABEL_IMAGE = Target.the("The product IS_BEVERAGE field")
                .located(By.xpath("//img[@src='/img/bottle_deposit_example.webp']"));


    public static Target CASE_PHOTO_UPLOAD_BUTTON(String value) {
        return Target.the("CASE_PHOTO_UPLOAD")
                .located(By.xpath("//span[text()='" + value + "']/following-sibling::div//span[text()='Upload']"));
    }

    public static Target CASE_PHOTO_UPLOAD(String value) {
        return Target.the("CASE_PHOTO_UPLOAD")
                .located(By.xpath("//span[text()='" + value + "']/following-sibling::div//input[@type='file']"));
    }

    public static Target CASE_PACK_PHOTO(int i) {
        return Target.the("CASE_PACK_PHOTO")
                .located(By.xpath("//span[normalize-space()='Case Pack Photo']/following-sibling::div/*[not(contains(@class,'upload el-button'))][" + i + "]"));
    }
    public static Target MASTER_CARTON_PHOTO(int i) {
        return Target.the("CASE_PACK_PHOTO")
                .located(By.xpath("//span[normalize-space()='Master Carton Photo']/following-sibling::div/*[not(contains(@class,'upload el-button'))][" + i + "]"));
    }
    public static Target IMAGE_SKU_BEFORE(int i) {
        return Target.the("IMAGE_SKU_BEFORE")
                .located(By.xpath("(//div[@class='image'])[" + i + "]"));
    }

    public static Target CASES_PER_PALLET = Target.the("Cases Per Pallet field")
            .located(By.xpath("(//input[@type='number'])[9]"));
    public static Target CASES_PER_LAYER = Target.the("Cases Per Layers field")
            .located(By.xpath("(//input[@type='number'])[10]"));
    public static Target LAYERS_PER_FULL_PALLET_FIELD = Target.the("Layer per full pallet field")
            .located(By.xpath("(//input[@type='number'])[11]"));
    public static Target MASTER_CARTONS_PER_PALLET_FIELD = Target.the("Master Cartons per Pallet")
            .located(By.xpath("(//input[@type='number'])[12]"));
    public static Target CASE_PER_MASTER_FIELD = Target.the("Cases per Master Carton")
            .located(By.xpath("(//input[@type='number'])[13]"));
    public static Target MASTER_CARTONS_LENGTH_FIELD = Target.the("Master carton length")
            .located(By.xpath("(//input[@type='number'])[14]"));
    public static Target MASTER_CARTONS_WIDTH_FIELD = Target.the("Master carton width")
            .located(By.xpath("(//input[@type='number'])[15]"));
    public static Target MASTER_CARTONS_HEIGHT_FIELD = Target.the("Master carton height")
            .located(By.xpath("(//input[@type='number'])[16]"));
    public static Target MASTER_CARTONS_WAIGHT_FIELD = Target.the("Master carton Weight")
            .located(By.xpath("(//input[@type='number'])[17]"));


    public static Target MOQ_FIELD(String region) {
        return Target.the(region + " MOQ field")
                .located(By.xpath("//dt[normalize-space()='" + region + "']/following-sibling::dd//input"));
    }


    public static Target CREATE_PRODUCT_BUTTON = Target.the("Create Product Button")
            .located(By.xpath("//button/span[normalize-space()='Create']"));
    public static Target NUMBER_SKUs = Target.the("NUMBER_SKUs")
            .located(By.xpath("//span[@class='sub-header']"));
    public static Target INSTRUCTION_IMG = Target.the("INSTRUCTION_IMG")
            .located(By.xpath("//img[@src='/img/inbound-general-instruction.webp']"));

    public static Target ALERT = Target.the("The Alert message")
            .located(By.cssSelector("div[role=alert]"));

    public static Target D_2_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("//label[text()='" + title + "']//following-sibling::div//input"));
    }

    public static Target D_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("(//*[text()='" + title + "']//parent::*//following-sibling::div//input)[last()]|(//*[text()='" + title + "']//following-sibling::div//input)[last()] | (//label[normalize-space()='" + title + "']/following-sibling::div//textarea)[last()]"));
    }

    public static Target D_TEXTBOX2(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("//*[text()='" + title + "']//parent::label//following-sibling::div//input/parent::div"));
    }

    public static Target DYNAMIC_TEXT_BOX_ERROR(String name) {
        return Target.the("Label error of " + name)
                .locatedBy("//*[normalize-space()='" + name + "']/following-sibling::div//div[@class='el-form-item__error']");
    }

    public static Target DYNAMIC_TEXT_BOX_ERROR_LABEL(String name) {
        return Target.the("Label error of " + name)
                .locatedBy("//label[normalize-space()='" + name + "']/following-sibling::div//div[@class='el-form-item__error']|//span[normalize-space()='" + name + "']/ancestor::label/following-sibling::div//div[@class='el-form-item__error']");
    }

    public static Target DYNAMIC_TEXT_BOX_ERROR_MOQ(String name) {
        return Target.the("Label error of " + name)
                .locatedBy("//dt[normalize-space()='" + name + "']/following-sibling::dd//div[@class='el-form-item__error']");
    }

    public static Target DYNAMIC_ALERT_TEXT(String name) {
        if (name.contains("\"")) {
            return Target.the("Label error of " + name)
                    .locatedBy("//div[@role='alert']//*[contains(text(),'" + name + "')]");
        } else
            return Target.the("Label error of " + name)
                    .locatedBy("//div[@role='alert']//*[contains(text(),\"" + name + "\")]");
    }
}
