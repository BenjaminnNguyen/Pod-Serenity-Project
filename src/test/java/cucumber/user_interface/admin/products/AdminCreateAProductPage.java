package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminCreateAProductPage {

    public static Target BRAND_FIELD = Target.the("The brand field")
            .located(By.cssSelector("div.brand .el-input__inner"));

    public static Target THE_FIRST_SUGGESTION_OF_BRAND = Target.the("The first suggestion of brand")
            .located(By.cssSelector("div.popper-brand-select .el-select-dropdown__item:nth-child(1)"));

    public static Target PRODUCT_NAME_FIELD = Target.the("The product name field")
            .located(By.cssSelector("div.name .el-input__inner"));

    public static Target PRODUCT_TYPE = Target.the("The product type field")
            .located(By.cssSelector("div.product-type-cascader input"));

    public static Target PRODUCT_CATEGORY(String category) {
        return Target.the("The product type field")
                .located(By.xpath("//span[@class='el-cascader-node__label' and normalize-space()='" + category + "']"));
    }

    public static Target IS_BEVERAGE = Target.the("The product IS_BEVERAGE field")
            .located(By.xpath("//label[normalize-space()='Is this a beverage?']/following-sibling::div//input"));

    public static Target CONTAINER_TYPE = Target.the("The product IS_BEVERAGE field")
            .located(By.xpath("//label[normalize-space()='Container Type']/following-sibling::div//input"));

    public static Target UNIT_SIZE_TYPE = Target.the("The product type field")
            .located(By.cssSelector(".product-volume-unit-select .el-input__inner"));

    public static Target ALLOW_SAMPLE = Target.the("The allow sample request")
            .located(By.xpath("//div[@role='switch' and @aria-checked=\"true\"]"));

    public static Target THE_FIRST_SUGGESTION_OF_PRODUCT_TYPE = Target.the("The first suggestion of product type")
            .located(By.cssSelector("div.el-cascader__suggestion-panel li:first-child"));

    public static Target THE_COFFEE_BEANS_TYPE = Target.the("The Coffee Beans type")
            .located(By.cssSelector("body >div.popper-product-type-select li.el-select-dropdown__item:nth-child(17)"));

    public static Target CATEGORY_DAIRY = Target.the("Dairy")
            .located(By.cssSelector("div.categories >label:nth-child(1) .el-radio__input"));

    public static Target ADDITIONAL_FEE = Target.the("The unit width")
            .located(By.cssSelector(".percentage-input .el-input__inner"));

    public static Target UNIT_WIDTH_FIELD = Target.the("The unit width")
            .located(By.cssSelector("div.size_w .el-input__inner"));

    public static Target UNIT_HEIGHT_FIELD = Target.the("The unit height")
            .located(By.cssSelector("div.size_h .el-input__inner"));

    public static Target UNIT_LENGTH_FIELD = Target.the("The unit length")
            .located(By.cssSelector("div.size_l .el-input__inner"));

    public static Target CASE_WIDTH_FIELD = Target.the("The case width")
            .located(By.cssSelector("div.case_size_w .el-input__inner"));

    public static Target CASE_HEIGHT_FIELD = Target.the("The case height")
            .located(By.cssSelector("div.case_size_h .el-input__inner"));

    public static Target CASE_LENGTH_FIELD = Target.the("The case length")
            .located(By.cssSelector("div.case_size_l .el-input__inner"));

    public static Target CASE_WEIGHT_FIELD = Target.the("The case weight")
            .located(By.xpath("//label[@for='case_weight']/following-sibling::div//input"));

    public static Target ERROR_ALERT = Target.the("The case weight")
            .located(By.xpath("//div[@class='el-notification__content']"));

    public static Target PACKAGE_SIZE = Target.the("The package size field")
            .located(By.cssSelector("div.product-package-size-select .el-input__inner"));

    public static Target THE_FIRST_SUGGESTION_OF_PACKAGE_SIZE = Target.the("The first suggestion of package size")
            .located(By.cssSelector("div.popper-product-package-size-select .el-select-dropdown__item:nth-child(1)"));

    public static Target DYNAMIC_INPUT(String field) {
        return Target.the("Field " + field)
                .located(By.xpath("//*[contains(text(),'" + field + "')]/following-sibling::div//input | //*[contains(text(),'" + field + "')]/ancestor::label/following-sibling::div//input"));
    }

    public static Target DYNAMIC_INPUT_REGION_MOQ(String field) {
        return Target.the("")
                .located(By.xpath("//*[contains(text(),'" + field + "')]/parent::div/following-sibling::input"));
    }

    public static Target DYNAMIC_INPUT(String field, int i) {
        return Target.the("")
                .located(By.xpath("(//label[contains(text(),'" + field + "')]/following-sibling::div//input)[" + i + "]"));
    }

    public static Target INDIVIDUAL_SERVING = Target.the("The individual serving")
            .located(By.cssSelector("div.popper-product-package-size-select .el-select-dropdown__item:nth-child(1)"));

    public static Target BOTTLE_DEPOSIT_LABEL = Target.the("BOTTLE_DEPOSIT_LABEL")
            .locatedBy("//span[contains(text(),'Bottle Deposit Label')]/following-sibling::i");

    public static Target BOTTLE_DEPOSIT_LABEL_IMAGE = Target.the("BOTTLE_DEPOSIT_LABEL_IMAGE")
            .locatedBy("//div[@x-placement]//img[@src='/img/bottle_deposit_example.png']");

    public static Target BOTTLE_DEPOSIT_LABEL_UPLOAD_IMAGE = Target.the("BOTTLE_DEPOSIT_LABEL_IMAGE")
            .locatedBy("//label[@for='bottle_deposit_label_image_attributes']/following-sibling::div//input[@type='file']");

    public static Target UNIT_SIZE = Target.the("The weight field")
            .located(By.cssSelector("div.volume .el-input__inner"));

    public static Target CASES_PER_PALLET_FIELD = Target.the("Cases per pallet field")
            .located(By.cssSelector("div.case-per-pallet input"));

    public static Target CASES_PER_LAYER_FIELD = Target.the("Cases per layer field")
            .located(By.cssSelector("div.case-per-layer input"));

    public static Target LAYERS_PER_FULL_PALLET_FIELD = Target.the("Layers per Full Pallet")
            .located(By.cssSelector("div.layer-per-pallet input"));

    public static Target CREATE_BUTTON = Target.the("Create button")
            .located(By.cssSelector(".el-form-item button.el-button--primary"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target ADD_STATE_FEE_BUTTON = Target.the("ADD_STATE_FEE_BUTTON")
            .located(By.xpath("//span[contains(text(),'Add a state fee')]"));

    public static Target ADD_STATE_FEE_INPUT = Target.the("ADD_STATE_FEE_BUTTON")
            .located(By.xpath("(//input[@placeholder='Add a state fee'])[last()]"));

    public static Target ADD_STATE_FEE_INPUT2 = Target.the("ADD_STATE_FEE_BUTTON")
            .located(By.xpath("(//input[@placeholder='Add a state fee'])"));

    public static Target ADD_STATE_FEE_VALUE = Target.the("ADD_STATE_FEE_BUTTON")
            .located(By.xpath("(//div[contains(@class,'fee_price_cents')]//input)[last()]"));

    public static Target DELETE_STATE_FEE(int i) {
        return Target.the("")
                .located(By.xpath("(//div[@class='el-form-item__content']//div[@class='el-row']//button)[" + i + "]"));
    }

    public static Target TAG_EXPIRY(String tagName) {
        return Target.the("")
                .located(By.xpath("//*[contains(text(),'" + tagName + "')]/parent::div/following-sibling::div//input"));
    }

    public static Target DYNAMIC_TEXT_BOX_ERROR(String name) {
        return Target.the("Label error of " + name)
                .locatedBy("//label[normalize-space()='" + name + "']/following-sibling::div/div[@class='el-form-item__error']");
    }

    public static Target DYNAMIC_IMAGE_ERROR(String name) {
        return Target.the("image error of " + name)
                .locatedBy("//label[text()='" + name + "']/following-sibling::div//span[@class='unsupported']");
    }


    public static Target CATEGORY_ERROR = Target.the("")
            .located(By.xpath("//div[@class='product-category-container-group']//div[@class='el-form-item__error']"));

    public static Target REGION_MOQ_ERROR(String field) {
        return Target.the("")
                .located(By.xpath("//*[contains(text(),'" + field + "')]/ancestor::div[@class='el-form-item__content']/div[@class='el-form-item__error']"));
    }

    public static Target D_DROPDOWN_VALUE(String value) {
        return Target.the("")
                .located(By.xpath("//div[contains(@class,'el-select-dropdown') and contains(@x-placement,'start')]//span[contains(text(),'" + value + "')]"));
    }
    public static Target D_DROPDOWN_VALUE_DISABLE(String value) {
        return Target.the("")
                .located(By.xpath("//div[contains(@class,'el-select-dropdown') and contains(@x-placement,'start')]//span[contains(text(),'" + value + "')]/ancestor::li"));
    }

    public static Target UPC_TAG(String value) {
        return Target.the("")
                .located(By.xpath("//span[contains(@class,'upc-tag " + value + "')]"));
    }

    public static Target UPC_TAG_POPUP = Target.the("UPC_TAG_POPUP")
            .located(By.xpath("//div[@x-placement]//div[@class='barcode-wrapper barcode'] "));

    public static Target CASE_PACK_PHOTO = Target.the("CASE_PACK_PHOTO")
            .located(By.xpath("//label[@for='case_pack_images_attributes']/following-sibling::div//input[@type='file']"));

    public static Target CASE_PACK_PHOTO_DETAIL = Target.the("CASE_PACK_PHOTO_DETAIL")
            .located(By.xpath("//div[normalize-space()='Case Pack Photo']/following-sibling::section//input[@type='file']"));

    public static Target MASTER_CARTON_PHOTO_DETAIL = Target.the("MASTER_CARTON_PHOTO_DETAIL")
            .located(By.xpath("//div[normalize-space()='Master Carton Photo']/following-sibling::section//input[@type='file']"));

    public static Target MASTER_CARTON_PHOTO = Target.the("CASE_PACK_PHOTO")
            .located(By.xpath("//label[@for='master_carton_images_attributes']/following-sibling::div//input[@type='file']"));

}
