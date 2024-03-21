package cucumber.user_interface.admin.Brand;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class BrandDetailPage {

    public static Target STATE_STATUS = Target.the("The state status")
            .located(By.cssSelector("div.status-tag"));

    public static Target NAME = Target.the("The brand name")
            .locatedBy("//dt[text()='Name']/following-sibling::dd//div/span[@class='name']");

    public static Target DESCRIPTION = Target.the("The brand desc")
            .locatedBy("(//dt[text()='Description']/following-sibling::dd//div[contains(@class,'content')]/span)[1]");

    public static Target MICRO_DESCRIPTION = Target.the("The brand micro-desc")
            .locatedBy("(//dt[text()='Micro-descriptions']/following-sibling::dd//div[contains(@class,'content')]/span)[1]");

    public static Target INBOUND_INVENTORY_MOQ_DETAIL = Target.the("The brand inbound inventory moq")
            .locatedBy("//dt[text()='Inbound Inventory MOQ']//following-sibling::dd//div[contains(@class,'content')]/span");

    public static Target TAGS = Target.the("The brand tags")
            .located(By.cssSelector("div[class='tags']"));

    public static Target VENDOR_COMPANY = Target.the("The brand Vendor company")
            .located(By.cssSelector("span.vendor-company"));

    public static Target CITY = Target.the("The brand Vendor company")
            .locatedBy("(//dt[text()='City']/following-sibling::dd//div[contains(@class,'content')]/span)[1]");

    public static Target STATE = Target.the("The brand state")
            .locatedBy("(//dt[text()='State']/following-sibling::dd//div[contains(@class,'content')]/span)[last()]");

    public static Target INBOUND_INVENTORY_MOQ = Target.the("The brand inbound inventory mod")
            .locatedBy("//dt[text()='Inbound Inventory MOQ']/following-sibling::dd//div[contains(@class,'content')]/span");

    public static Target DEACTIVATE_THIS_BRAND_BUTTON = Target.the("The Deactivate this brand button")
            .located(By.xpath("//span[contains(text(),'Deactivate this brand')]"));

    public static Target OK_DEACTIVATE_BRAND = Target.the("Ok - Deactivate brand")
            .located(By.cssSelector("div.el-message-box .el-message-box__btns .el-button--primary"));

    public static Target SET_FIXED_BUTTON = Target.the("Set Fixed button")
            .located(By.xpath("//span[contains(text(),'Set fixed %')]"));

    public static Target ACTIVE_THIS_BRAND_BUTTON = Target.the("The Active this brand button")
            .located(By.xpath("//span[text()='Activate this brand']"));

    public static Target OK_ACTIVATE_BRAND = Target.the("Ok - Activate brand")
            .located(By.cssSelector("div.el-message-box .el-message-box__btns .el-button--primary"));

    public static Target REMOVED_SPECIFIED_BUTTON = Target.the("The removed specified button")
            .located(By.xpath("//span[contains(text(),'Remove specified %')]"));

    public static Target OK_REMOVE_FIXED_PRICING_BUTTON = Target.the("OK - Remove fixed pricing")
            .located(By.cssSelector("div.el-message-box .el-message-box__btns .el-button--primary"));

    public static Target DELETE_BRAND_BUTTON = Target.the("Delete brand button")
            .locatedBy("(//header//div[@class='actions']//button)[1]");

    /**
     * Logo & Image
     */

    public static Target IMAGE_SECTION = Target.the("Image section")
            .locatedBy("//div[@class='section-title' and text()='Images']");

    public static Target COVER_IMAGE = Target.the("Cover Image")
            .located(By.cssSelector("div.brand-images-section .cover  .preview > input"));

    public static Target LOGO_IMAGE = Target.the("Logo Image")
            .located(By.cssSelector("div.brand-images-section .logo  .preview > input"));

    public static Target IMAGE_ADDED(String type, String file) {
        return Target.the(type + " image added")
                .locatedBy("//div[@class='" + type + "']//div[contains(@style,'" + file + "')]");
    }


    public static Target LOGO_IMAGE_UNSUPPORTED = Target.the("Logo Image unsupported")
            .locatedBy("//div[@class='logo']//span[text()='Unsupported format for previewing']");

    public static Target COVER_IMAGE_UNSUPPORTED = Target.the("Cover Image unsupported")
            .locatedBy("//div[@class='cover']//span[text()='Unsupported format for previewing']");

    public static Target SAVE_IMAGE_BUTTON = Target.the("The Save Image button")
            .located(By.cssSelector("div.brand-images-section .actions .el-button--primary"));

    public static Target SUB_IMAGE_UNSUPPORTED = Target.the("Sub Image unsupported")
            .locatedBy("//div[@class='sub-images']//span[text()='Unsupported format for previewing']");

    public static Target THE_FIRST_SUB_IMAGE = Target.the("The first sub-image")
            .located(By.cssSelector("div.sub-images div.image:first-child input"));

    public static Target THE_SECOND_SUB_IMAGE = Target.the("The second sub-image")
            .located(By.cssSelector("div.sub-images div.item:nth-child(2) input"));

    public static Target ADD_A_SUB_IMAGE = Target.the("Add a sub-image button")
            .located(By.xpath("//span[contains(text(), 'Add a sub-image')]"));

    public static Target SUB_IMAGE(int i) {
        return Target.the("Add a sub-image button")
                .locatedBy("(//div[@class='sub-images']//label/input)[" + i + "]");
    }

    public static Target THE_DELETE_BUTTON_OF_SUB_IMAGE_2 = Target.the("The delete button of the second sub-image")
            .located(By.cssSelector("div.sub-images .item:nth-child(2) .actions button:nth-child(2)"));

    public static Target THE_DELETE_BUTTON_OF_SUB_IMAGE_1 = Target.the("The delete button of the second sub-image")
            .located(By.cssSelector("div.sub-images .item:nth-child(1) .actions button:nth-child(2)"));

    // Store - Specific %
    public static Target ADD_STORE_SPECIFIC_BUTTON = Target.the("Add Store Specific button")
            .located(By.cssSelector("span.add-store-specific-percentage"));

    public static Target popup_SPECIFIC_STORES_TYPE = Target.the("The Specific Stores button")
            .located(By.cssSelector("div.el-dialog__body div.type .store_ids"));

    public static Target popup_SPECIFIC_BUYER_COMPANY_TYPE = Target.the("The Specific buyer company button")
            .located(By.cssSelector("div.el-dialog__body div.type .buyer_company_id"));

    public static Target popup_BUYER_COMPANY_FIELD = Target.the("The Buyer company field")
            .located(By.cssSelector("div.buyer-company-select input"));

    public static Target popup_STORE_FIELD = Target.the("The Store field")
            .located(By.cssSelector("div.multiple-stores-select div.store-select input.el-input__inner"));

    public static Target popup_THE_FIRST_STORE_ON_THE_SUGGESTION = Target.the("The first Store on the suggestion")
            .located(By.cssSelector("div.popper-stores-select li:first-child"));

    public static Target popup_THE_FIRST_COMPANY_ON_THE_SUGGESSTION = Target.the("The first Company on the suggestion")
            .located(By.cssSelector("div.popper-buyer-company-select li:nth-child(1)"));

    public static Target popup_PERCENTAGE_FIELD = Target.the("The Percentage field")
            .located(By.cssSelector("div.el-dialog__body div.percentage-input input.el-input__inner"));

    public static Target popup_EXPIRE_DATE_FIELD = Target.the("The Expire Date field")
            .located(By.cssSelector("div.el-dialog__body .receive-date input"));

    public static Target popup_CREATE_COMMISSION_BUTTON = Target.the("The Create Commission button")
            .located(By.cssSelector("div.el-dialog__body button.el-button--submit"));

    public static Target DIALOG_MESSAGE(String message) {
        return Target.the("Dialog message")
                .locatedBy("//div[@role='dialog']//div[contains(@class,'message') and text()='" + message + "']");
    }

    /**
     * Popup history active - deactivate
     */

    public static Target ACTIVE_HISTORY_STATE = Target.the("Active or deactivate history state")
            .located(By.xpath("//div[@x-placement]//td[@class='value']"));

    public static Target ACTIVE_HISTORY_UPDATE_BY = Target.the("Active or deactivate history update by")
            .located(By.xpath("(//div[@x-placement]//td[@class='initated-by'])[1]"));

    public static Target ACTIVE_HISTORY_UPDATE_ON = Target.the("Active or deactivate history update by")
            .located(By.xpath("(//div[@x-placement]//td[@class='date'])[1]"));

    /**
     * Footer link
     */

    public static Target FOOTER_LINK(String link) {
        return Target.the("Active or deactivate history update by")
                .located(By.xpath("//ul[@class='links']//a[text()=\"" + link + "\"]"));
    }
}
