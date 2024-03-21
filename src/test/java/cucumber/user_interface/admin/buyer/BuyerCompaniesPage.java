package cucumber.user_interface.admin.buyer;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class BuyerCompaniesPage {

    public static Target BUYER_NAME = Target.the("Result name Company")
            .locatedBy("//td[contains(@class,'name')]//span");

    public static Target EIN = Target.the("EIN of company")
            .locatedBy("//td[contains(@class,'ein')]//div");

    public static Target WEBSITE = Target.the("Website of company")
            .locatedBy("//td[contains(@class,'website')]//span");

    public static Target STATUS = Target.the("Status of company")
            .locatedBy("//td[contains(@class,'status')]//div");

    public static Target BUYER_NAME_RESULT(String name) {
        return Target.the("Buyer name in result")
                .locatedBy("//td[contains(@class,'name')]//span[contains(@data-original-text,'" + name + "')]");
    }

    public static Target BUYER_COMPANY_DELETE_RESULT(String name) {
        return Target.the("Buyer name in result")
                .locatedBy("(//span[contains(@data-original-text,'" + name + "')]/ancestor::td/following-sibling::td//button)[2]");
    }

    public static Target D_CHECKBOX_RESULT(String buyerCompany) {
        return Target.the("Buyer name in result")
                .locatedBy("//span[contains(@data-original-text,'" + buyerCompany + "')]/ancestor::td/preceding-sibling::td//input");
    }

    public static Target BUYER_ID = Target.the("Result id Company")
            .locatedBy("//td[contains(@class,'id')]//div");

    /**
     * Buyer Company Detail Page
     */
    public static Target GENERAL_INFO = Target.the("General information")
            .located(By.xpath("//div[text()='General information']"));

    public static Target DETAIL_STATE = Target.the("State in detail page")
            .located(By.xpath("(//dt[text()='State']/following-sibling::dd//div)[1]"));

    public static Target DETAIL_NAME = Target.the("Name in detail page")
            .located(By.xpath("//span[@class='name']"));

    public static Target DETAIL_MANAGED_BY = Target.the("Managed by in detail page")
            .located(By.xpath("//span[@class='manager']"));

    public static Target DETAIL_MANAGED_BY_EDIT = Target.the("Managed by in detail page")
            .located(By.xpath("//span[@class='manager']/parent::div"));

    public static Target DETAIL_LAUNCHED_BY = Target.the("Launched by in detail page")
            .located(By.xpath("//span[@class='launcher']"));

    public static Target DETAIL_LAUNCHED_BY_EDIT = Target.the("Launched by in detail page")
            .located(By.xpath("//span[@class='launcher']/parent::div"));

    public static Target DETAIL_STORE_TYPE = Target.the("Store type in detail page")
            .located(By.xpath("//span[@class='store-type']"));

    public static Target DETAIL_EIN = Target.the("EIN in detail page")
            .located(By.xpath("//span[@class='ein']"));

    public static Target DETAIL_EIN_BY_EDIT = Target.the("EIN by in detail page")
            .located(By.xpath("//span[@class='ein']/parent::div"));


    public static Target DETAIL_WEBSITE = Target.the("Website in detail page")
            .located(By.xpath("//span[@class='website']"));

    public static Target DETAIL_EDI = Target.the("EDI in detail page")
            .located(By.xpath("//div[contains(@class,'invoice-option')]/span/span"));

    public static Target DETAIL_FUEL = Target.the("Fuel in detail page")
            .located(By.xpath("//div[contains(@class,'fuel-surcharge')]/span/span"));

    public static Target DETAIL_CREDIT = Target.the("Credit in detail page")
            .located(By.xpath("//span[@class='credit-limit']"));

    public static Target DETAIL_ONBOARDING_STATE = Target.the("Onboarding status in detail page")
            .located(By.xpath("(//div[@class='status-tag'])[2]"));

    public static Target DETAIL_EDI_STATE = Target.the("Edi in detail page")
            .located(By.xpath("(//dt[text()='Allow EDI orders for this retailer']/following-sibling::dd//span)[last()]"));

    public static Target DETAIL_FUEL_SURCHARGE = Target.the("Fuel surcharge in detail page")
            .located(By.xpath("(//dt[text()='Fuel surcharge']/following-sibling::dd//span)[last()]"));

    public static Target DETAILS_IMG_CETI(String img) {
        return Target.the("Image certificate")
                .locatedBy("//div[text()='" + img + "']");
    }

    public static Target D_DETAIL_EDIT(String value) {
        return Target.the(value + " in vendor company")
                .located(org.openqa.selenium.By.xpath("(//dt[text()='" + value + "']/following-sibling::dd/div/span)[1]"));
    }

    public static Target ACTIVE_HISTORY_ICON = Target.the("Active or deactivate history icon")
            .located(org.openqa.selenium.By.xpath("//div[contains(@class,'active')]//span[@class='el-popover__reference-wrapper']"));

    /**
     * Popup history active - deactivate
     */

    public static Target ACTIVE_HISTORY_STATE = Target.the("Active or deactivate history state")
            .located(org.openqa.selenium.By.xpath("(//div[@x-placement]//td[@class='value']/span)[1]"));

    public static Target ACTIVE_HISTORY_UPDATE_BY = Target.the("Active or deactivate history update by")
            .located(org.openqa.selenium.By.xpath("(//div[@x-placement]//td[@class='initated-by'])[1]"));

    public static Target ACTIVE_HISTORY_UPDATE_ON = Target.the("Active or deactivate history update by")
            .located(org.openqa.selenium.By.xpath("(//div[@x-placement]//td[@class='date'])[1]"));

    /**
     * Tags popup in buyer company detail
     */

    public static Target TAGS_TEXTBOX_POPUP = Target.the("Tag textbox in popup")
            .located(org.openqa.selenium.By.xpath("//div[@role='tooltip']//input[@placeholder='Select a tag']"));

    public static Target TAG_IN_DETAIL = Target.the("Tag in detail")
            .located(org.openqa.selenium.By.xpath("//div[@class='tags']//span"));

    public static Target TAGS_POPUP_LABEL = Target.the("Tag popup label")
            .located(org.openqa.selenium.By.xpath("//div[@role='tooltip']//label[text()='Tags']"));

    public static Target TAGS_IN_POPUP(String tag) {
        return Target.the("Tag in popup tags")
                .located(org.openqa.selenium.By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']"));
    }

    public static Target TAGS_IN_DETAIL(String tag) {
        return Target.the("Tag in detail")
                .located(org.openqa.selenium.By.xpath("//div[@class='tags']//span[text()='" + tag + "']"));
    }

    public static Target TAGS_EXPIRY_DATE_IN_DETAIL(String tag) {
        return Target.the("Tag expiry date in detail")
                .located(org.openqa.selenium.By.xpath("//div[@class='tags']//span[text()='" + tag + "']/following-sibling::span/span"));
    }

    public static Target TAGS_EXPIRY_TEXTBOX_IN_POPUP(String tag) {
        return Target.the("Tag expiry date textbox in popup tags")
                .located(org.openqa.selenium.By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/input"));
    }

    public static Target TAGS_DELETE_BUTTON_IN_POPUP(String tag) {
        return Target.the("Tag delete button in popup tags")
                .located(org.openqa.selenium.By.xpath("//div[@role='tooltip']//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    public static Target TAGS_UPDATE_BUTTON_POPUP = Target.the("Tag update button in popup")
            .located(org.openqa.selenium.By.xpath("//div[@role='tooltip' and @x-placement]//*[contains(text(),'Update')]"));

    public static Target TAG_CREATE_VENDOR_DELETE_BUTTON(String tag) {
        return Target.the("Tag after delete button in create vendor popup")
                .located(org.openqa.selenium.By.xpath("//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    /**
     * Create buyer company
     */

    public static Target CREATE_BUYER_COMPANY_BUTTON = Target.the("Create buyer company button")
            .locatedBy("//div[@class='actions']//span[text()='Create']");


    public static Target CREATE_NEW_BUYER_COMPANY_POPUP = Target.the("Create buyer company button")
            .locatedBy("//div[@aria-label='Create new Buyer company']");

    public static Target CREATE_BUYER_NAME_TEXTBOX = Target.the("Name textbox in create buyer company popup")
            .locatedBy("//label[text()='Name']/following-sibling::div//input");

    public static Target CREATE_BUYER_MANAGED_TEXTBOX = Target.the("Managed by textbox in create buyer company popup")
            .locatedBy("//label[text()='Manage by']/following-sibling::div//input");

    public static Target CREATE_BUYER_LAUNCH_TEXTBOX = Target.the("Launch by textbox in create buyer company popup")
            .locatedBy("//label[text()='Launch by']/following-sibling::div//input");

    public static Target CREATE_BUYER_STORE_TYPE_TEXTBOX = Target.the("Store type textbox in create buyer company popup")
            .locatedBy("//label[text()='Store type']/following-sibling::div//input");

    public static Target CREATE_BUYER_EIN_TEXTBOX = Target.the("Ein textbox in create buyer company popup")
            .locatedBy("//label[text()='EIN']/following-sibling::div//input");

    public static Target CREATE_BUYER_WEBSITE_TEXTBOX = Target.the("Website textbox in create buyer company popup")
            .locatedBy("//label[text()='Website']/following-sibling::div//input");

    public static Target CREATE_BUYER_TAG_TEXTBOX = Target.the("Tags textbox in create buyer company popup")
            .locatedBy("//div[@role='dialog']//label[text()='Tags']/following-sibling::div//input");

    public static Target CREATE_BUYER_EDI_RADIOBUTTON = Target.the("EDI radio button in create buyer company popup")
            .locatedBy("//label[text()='Allow EDI orders for this retailer']/following-sibling::div//div[contains(@class,'switch')]");

    public static Target CREATE_BUYER_FUEL_RADIOBUTTON = Target.the("Fuel surcharge radio button in create buyer company popup")
            .locatedBy("//label[text()='Fuel surcharge']/following-sibling::div//div[contains(@class,'switch')]");

    public static Target CREATE_BUYER_BUTTON_CREATE = Target.the("Button create in create buyer company popup")
            .locatedBy("//div[@role='dialog']//button//span[text()='Create']");

    public static Target SIMILAR_VENDOR_COMPANY(String vendorCompany) {
        return Target.the("Similar vendor company")
                .located(org.openqa.selenium.By.xpath("//p[@class='el-alert__description']//span[text()='" + vendorCompany + "']"));
    }

    public static Target SIMILAR_DESCRIPTION = Target.the("Similar description")
            .located(org.openqa.selenium.By.xpath("//p[@class='el-alert__description']/div[@class='text']"));

    /**
     * Buyer company result
     */
    public static Target ID_BUYER_COMPANY_RESULT(String buyerCompany) {
        return Target.the("ID Buyer company in result")
                .locatedBy("//span[@data-original-text='" + buyerCompany + "']/ancestor::td/preceding-sibling::td/div");
    }

    public static Target BUYER_COMPANY_RESULT(String buyerCompany) {
        return Target.the("Buyer company in result")
                .locatedBy("//a[@class='name']/span[@data-original-text='" + buyerCompany + "']");
    }

    public static Target EIN_RESULT(String buyerCompany) {
        return Target.the("Ein in result")
                .locatedBy("//span[@data-original-text='" + buyerCompany + "']//ancestor::td//following-sibling::td[contains(@class,'ein')]/div");
    }

    public static Target WEBSITE_RESULT(String buyerCompany) {
        return Target.the("Website in result")
                .locatedBy("//span[@data-original-text='" + buyerCompany + "']//ancestor::td//following-sibling::td[contains(@class,'website')]//span");
    }

    public static Target STATUS_RESULT(String buyerCompany) {
        return Target.the("Status in result")
                .locatedBy("//span[@data-original-text='" + buyerCompany + "']//ancestor::td//following-sibling::td[contains(@class,'status')]/div/div");
    }

    /**
     * Buyer company document
     */

    public static Target COMPANY_DOCUMENT_SELECT_LABEL = Target.the("Company document preview file")
            .located(org.openqa.selenium.By.xpath("//div[text()='Company documents']//following-sibling::div//div[@class='input']"));

    public static Target COMPANY_DOCUMENT_PREVIEW_TOOLTIP = Target.the("Company document preview tool tip")
            .located(org.openqa.selenium.By.xpath("//div[text()='Choose a document file']"));

    public static Target COMPANY_DOCUMENT_SELECT_ICON = Target.the("Company document preview icon")
            .located(org.openqa.selenium.By.xpath("//div[text()='Company documents']//following-sibling::div//div[@class='icon']"));

    public static Target COMPANY_DOCUMENT_PREVIEW_ICON_TOOLTIP = Target.the("Company document preview icon tool tip")
            .located(org.openqa.selenium.By.xpath("//div[text()='The maximum file size is 10MB']"));

    public static Target COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(String index) {
        return Target.the("Company document preview description")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//div[@class='description']//input)[" + index + "]"));
    }

    public static Target COMPANY_DOCUMENT_UPLOAD_FILE(String index) {
        return Target.the("Company document upload file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//div[@class='input']//input)[" + index + "]"));
    }

    public static Target COMPANY_DOCUMENT_FILE_UPLOADED(String index) {
        return Target.the("Company document uploaded file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//div[@class='input']//div[@class='file'])[" + index + "]"));
    }

    public static Target COMPANY_DOCUMENT_DOWNLOAD_BUTTON(int i) {
        return Target.the("Company document uploaded file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//a//span[text()='Download'])[" + i + "]"));
    }

    public static Target COMPANY_DOCUMENT_REMOVE_BUTTON(int i) {
        return Target.the("Company document remove button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//span[text()='Remove'])[" + i + "]"));
    }

    public static Target COMPANY_DOCUMENT_REMOVE_BUTTON(String index) {
        return Target.the("Company document remove button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Company documents']//following-sibling::div//div[@class='actions']//span[text()='Remove'])[" + index + "]"));
    }

    /**
     * Buyer business license certificates
     */

    public static Target BUSINESS_LICENSE_CERTIFICATES_LABEL = Target.the("Business license certificates preview file")
            .located(org.openqa.selenium.By.xpath("//div[text()='Business license certificates']//following-sibling::div//div[@class='input']"));

    public static Target BUSINESS_LICENSE_CERTIFICATES_TOOLTIP = Target.the("Business license certificates preview tool tip")
            .located(org.openqa.selenium.By.xpath("//div[text()='Choose a business license certificates file']"));

    public static Target BUSINESS_LICENSE_CERTIFICATES_REMOVE_BUTTON(String index) {
        return Target.the("Business license certificates remove button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Business license certificates']//following-sibling::div//div[@class='actions']//span[text()='Remove'])[" + index + "]"));
    }

    public static Target BUSINESS_LICENSE_CERTIFICATES_SAVE_BUTTON = Target.the("Business license certificates save button")
            .located(org.openqa.selenium.By.xpath("//div[text()='Business license certificates']//following-sibling::div[@class='actions']//span[text()='Save']"));

    public static Target BUSINESS_LICENSE_CERTIFICATES_SELECT_ICON = Target.the("Business license certificates preview icon")
            .located(org.openqa.selenium.By.xpath("//div[text()='Business license certificates']//following-sibling::div//div[@class='icon']"));

    public static Target BUSINESS_LICENSE_CERTIFICATES_ICON_TOOLTIP = Target.the("Business license certificates preview icon tool tip")
            .located(org.openqa.selenium.By.xpath("//div[text()='The maximum file size is 10MB']"));

    public static Target BUSINESS_LICENSE_CERTIFICATES_UPLOAD_FILE(String index) {
        return Target.the("Business license certificates upload file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Business license certificates']//following-sibling::div//div[@class='input']//input)[" + index + "]"));
    }

    public static Target BUSINESS_LICENSE_CERTIFICATES_FILE_UPLOADED(String index) {
        return Target.the("Business license certificates uploaded file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Business license certificates']//following-sibling::div//div[@class='input']//div[@class='file'])[" + index + "]"));
    }

    public static Target BUSINESS_LICENSE_DOWNLOAD_BUTTON(int i) {
        return Target.the("Business license certificates download button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Business license certificates']//following-sibling::div//a//span[text()='Download'])[" + i + "]"));
    }

    public static Target BUSINESS_LICENSE_REMOVE_BUTTON(String index) {
        return Target.the("Business license certificates remove button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Business license certificates']//following-sibling::div//div[@class='actions']//span[text()='Remove'])[" + index + "]"));
    }

    /**
     * Buyer resale certificates
     */

    public static Target RESALE_CERTIFICATES_SAVE_BUTTON = Target.the("Resale certificates save button")
            .located(org.openqa.selenium.By.xpath("//div[text()='Resale certificates']//following-sibling::div[@class='actions']//span[text()='Save']"));

    public static Target RESALE_CERTIFICATES_LABEL = Target.the("Resale license certificates preview file")
            .located(org.openqa.selenium.By.xpath("//div[text()='Resale certificates']//following-sibling::div//div[@class='input']"));

    public static Target RESALE_CERTIFICATES_TOOLTIP = Target.the("Resale certificates preview tool tip")
            .located(org.openqa.selenium.By.xpath("//div[text()='Choose a resale certificates file']"));

    public static Target RESALE_CERTIFICATES_SELECT_ICON = Target.the("Resale certificates preview icon")
            .located(org.openqa.selenium.By.xpath("//div[text()='Resale certificates']//following-sibling::div//div[@class='icon']"));

    public static Target RESALE_CERTIFICATES_UPLOAD_FILE(String index) {
        return Target.the("Resale certificates upload file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Resale certificates']//following-sibling::div//div[@class='input']//input)[" + index + "]"));
    }

    public static Target RESALE_CERTIFICATES_REMOVE_BUTTON(String index) {
        return Target.the("Resale certificates remove button")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Resale certificates']//following-sibling::div//div[@class='actions']//span[text()='Remove'])[" + index + "]"));
    }

    public static Target RESALE_CERTIFICATES_FILE_UPLOADED(String index) {
        return Target.the("Resale certificates uploaded file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Resale certificates']//following-sibling::div//div[@class='input']//div[@class='file'])[" + index + "]"));
    }

    public static Target RESALE_CERTIFICATES_DOWNLOAD_BUTTON(int i) {
        return Target.the("Resale certificates uploaded file")
                .located(org.openqa.selenium.By.xpath("(//div[text()='Resale certificates']//following-sibling::div//a//span[text()='Download'])[" + i + "]"));
    }

    /**
     * Buyer resale certificates
     */

    public static Target SET_REFERRER_VENDOR_COMPANY = Target.the("Set Referrer Vendor Company")
            .located(org.openqa.selenium.By.xpath("//span[text()='Set Referrer Vendor Company']"));

    public static Target SET_REFERRER_VENDOR_COMPANY_TEXTBOX = Target.the("Set Referrer Vendor Company textbox")
            .located(org.openqa.selenium.By.xpath("//label[text()='Select a vendor company as the referrer for all stores under this buyer company']/following-sibling::div//input"));

    /**
     * Create custom fiel
     */

    public static Target CREATE_NEW_BUYER_FIELD_LABEL = Target.the("Create new buyer field label")
            .located(org.openqa.selenium.By.xpath("//div[@role='dialog']//span[contains(@class,'title')]"));
}
