package cucumber.user_interface.admin.Brand;

import net.serenitybdd.screenplay.targets.Target;

public class BrandReferralPage {

    /**
     * Brand Referral Result
     */
    public static Target D_IN_RESULT(String value) {
        return Target.the(value + " in result table")
                .locatedBy("(//td[contains(@class,'" + value + "')]//span)[1]");
    }

    public static Target D_BRAND_IN_RESULT(int index, String brand) {
        return Target.the("Brand in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']");
    }

    public static Target D_EMAIL_IN_RESULT(int index, String brand) {
        return Target.the("Brand in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']/ancestor::td/following-sibling::td[@class='email']//span");
    }

    public static Target D_CONTACT_IN_RESULT(int index, String brand) {
        return Target.the("Contact in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']/ancestor::td/following-sibling::td[@class='contact-name']//span");
    }

    public static Target D_WORKING_IN_RESULT(int index, String brand) {
        return Target.the("Working in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']/ancestor::td/following-sibling::td[@class='working-with-brand']//span");
    }

    public static Target D_ONBOARD_IN_RESULT(int index, String brand) {
        return Target.the("Onboarded in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']/ancestor::td/following-sibling::td[@class='onboarded']//span");
    }

    public static Target D_VENDOR_COMPANY_IN_RESULT(int index, String brand) {
        return Target.the("Vendor company in result table")
                .locatedBy("//tr[" + index + "]//span[text()='" + brand + "']/ancestor::td/following-sibling::td[@class='vendor-company']//span");
    }

    public static Target D_DELETE_IN_RESULT(String brand) {
        return Target.the("Delete button of brand " + brand + " in result table")
                .locatedBy("//span[text()='" + brand + "']//ancestor::td/following-sibling::td[@class='actions']//button");
    }

    public static Target ID_BRAND_REFERRAL = Target.the("Brand referral in detail")
            .locatedBy("(//a[contains(@href,'/brands/referrals/')])[1]");

    /**
     * Brand Referral Detail - General information
     */
    public static Target STORE_DETAIL = Target.the("Store in general information")
            .locatedBy("(//dt[text()='Store']/following-sibling::dd//span[@class='buyer-company-name'])[1]");

    public static Target BUYER_DETAIL = Target.the("Brand referral in detail")
            .locatedBy("(//dt[text()='Buyer']/following-sibling::dd//span[@class='buyer-company-name'])[1]");

    public static Target DATE_DETAIL = Target.the("Date referral in detail")
            .locatedBy("//dt[text()='Date Submitted']/following-sibling::dd");

    /**
     * Brand Referral Detail
     */

    public static Target ROW_IN_BRAND_TABLE = Target.the("Row in brand table")
            .locatedBy("//tbody/tr");

    public static Target CHECKBOX(int row) {
        return Target.the("Checkbox textbox")
                .locatedBy("//tbody//tr[" + row + "]//td[1]//input");
    }

    public static Target BRAND_TEXTBOX(int row) {
        return Target.the("Brand name textbox")
                .locatedBy("//tbody//tr[" + row + "]//td[2]//input");
    }

    public static Target EMAIL_TEXTBOX(int row) {
        return Target.the("Email textbox")
                .locatedBy("//tbody//tr[" + row + "]//td[3]//input");
    }

    public static Target CONTACT_TEXTBOX(int row) {
        return Target.the("Contact textbox")
                .locatedBy("//tbody//tr[" + row + "]//td[4]//input");
    }

    public static Target WORKING_TEXTBOX(int row) {
        return Target.the("Working textbox")
                .locatedBy("//tbody//tr[" + row + "]//td[5]//input");
    }

    public static Target ONBOARD_LABEL(int row) {
        return Target.the("Onboard label")
                .locatedBy("(//tbody//tr[" + row + "]//td[6]//span)[1]");
    }

    public static Target VENDOR_COMPANY_LABEL(int row) {
        return Target.the("Vendor company label")
                .locatedBy("(//tbody//tr[" + row + "]//td[7]//span)[1]");
    }

    public static Target NOTE_TEXTAREA(int row) {
        return Target.the("Note in textarea")
                .locatedBy("//tbody//tr[" + row + "]//td[8]//textarea");
    }

    public static Target BRAND_DELETE_BUTTON(int row) {
        return Target.the("Brand delete button")
                .locatedBy("//tbody//tr[" + row + "]//button");
    }

    public static Target VENDOR_COMPANY_LINK(String row) {
        return Target.the("Vendor company link")
                .locatedBy("(//td[@class='vendor-company']//a)[" + row + "]");
    }

    public static Target BRAND_DETAIL_ERROR(int row) {
        return Target.the("Brand name error")
                .locatedBy("//tbody//tr[" + row + "]//td[2]//div[@class='el-form-item__error']");
    }

    /**
     * Confirm Onboard Brand Referral
     */

    public static Target CONFIRM_ONBOARD_POPUP = Target.the("Confirm Onboard Brand Referral")
            .locatedBy("//div[@role='dialog']//span[text()='Confirm Onboard Brand Referral']");

    public static Target VENDOR_COMPANY_SELECT = Target.the("Select vendor company")
            .locatedBy("//div[contains(@class,'vendor-company-select')]//input");

    public static Target CONFIRM_BUTTON = Target.the("Select vendor company")
            .locatedBy("//div[contains(@class,'vendor-company-select')]//input");
}
