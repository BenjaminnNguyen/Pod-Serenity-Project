package cucumber.user_interface.admin.inventory.withdrawalRequest;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class WithdrawalRequestsDetailPage {

    public static Target CREATE_BUTTON = Target.the("create button")
            .locatedBy("//button[@class='el-button el-button--primary']");

    public static Target BACK_BUTTON = Target.the("Back button")
            .locatedBy("(//div[@class='page-header']//button)[1]");
    public static Target WPL_BUTTON = Target.the("WPL button")
            .locatedBy("(//div[@class='page-header']//button)[2]");

    public static Target DELETE_BUTTON = Target.the("Delete button")
            .locatedBy("(//div[@class='page-header']//button)[3]");

    public static Target BOL = Target.the("BOL")
            .locatedBy("//dt[normalize-space()='BOL']/following-sibling::dd[1]");

    public static Target STATUS = Target.the("Status")
            .locatedBy("//div[@class='status-tag incoming-status']");

    public static Target CREATE_BY = Target.the("Status")
            .locatedBy("//dt[normalize-space()='Created by']/following-sibling::dd");
    public static Target CREATE_ON = Target.the("Status")
            .locatedBy("//dt[normalize-space()='Created on']/following-sibling::dd");

    public static Target CASE = Target.the("Status")
            .locatedBy("//div[@class='el-input el-input--small']//input[@type='number']");

    public static Target DYNAMIC_ALERT(String alert) {
        return Target.the("ALERT SUCCESS")
                .locatedBy("//p[text()='" + alert + "']");
    }

    public static Target DYNAMIC_INFO(String number, String info) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//td[contains(@class,'" + info + "')]"));
    }

    public static Target DYNAMIC_SPAN(String info) {
        return Target.the(info + "information")
                .located(By.xpath("//span[@class='" + info + "']"));
    }

    public static Target WAIT_REGION(String region) {
        return Target.the("Wait region")
                .locatedBy("(//dt[text()='Pickup region']/following-sibling::dd//span[text()='" + region + "'])[last()]");
    }

    public static Target PICKUP_DATE_COMPLETE = Target.the("Pickup date complete")
            .locatedBy("//div[@class='pickup-date']/span ");

    public static Target DYNAMIC_SPAN_TEXT(String info) {
        return Target.the(info + "information")
                .located(By.xpath("//span[normalize-space()='" + info + "']"));
    }

    public static Target DYNAMIC_TD(int i, String info) {
        return Target.the(info)
                .located(By.xpath("(//td[@class='" + info + "'])[" + i + "]"));
    }

    public static Target CASE(int i) {
        return Target.the("Case of Lot code")
                .located(By.xpath("(//div[contains(@class,'el-input el-input--small')]//input)[" + i + "]"));
    }

    public static Target DYNAMIC_SEARCH(String field) {
        return Target.the(field + "information")
                .located(By.xpath("//label[contains(normalize-space(),'" + field + "')]//following-sibling::div//input"));
    }

    public static Target ETA(String number) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//span[contains(@class,'eta')]"));
    }

    /**
     * Lot code information
     */

    public static Target PRODUCT_INFO(String lotcode) {
        return Target.the("Product information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/preceding-sibling::td[@class='product-name']"));
    }

    public static Target SKU_INFO(String lotcode) {
        return Target.the("SKU information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/preceding-sibling::td[@class='sku-name']/span[1]"));
    }

    public static Target LOTCODE_INFO(String lotcode) {
        return Target.the("Lotcode information")
                .located(By.xpath("//*[text()='" + lotcode + "']"));
    }

    public static Target LOTCODE_LINK(String lotcode) {
        return Target.the("Lotcode link")
                .located(By.xpath("//*[text()='" + lotcode + "']/a"));
    }

    public static Target ENDQTY_INFO(String lotcode) {
        return Target.the("End qty information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/following-sibling::td[@class='end-qty']"));
    }

    public static Target CASE_INFO(String lotcode) {
        return Target.the("Case information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/following-sibling::td[@class='case']//input"));
    }

    public static Target EXPIRY_DATE(String lotcode) {
        return Target.the("Case information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/following-sibling::td[@class='expiry-date']"));
    }

    public static Target PULL_QTY(String lotcode) {
        return Target.the("Case information by lotcode " + lotcode)
                .located(By.xpath("//*[text()='" + lotcode + "']/parent::td/following-sibling::td[@class='pull-quantity']"));
    }

    /**
     * General Information
     */
    public static Target D_TEXT_GENERAL(String fieldName) {
        return Target.the("Field name of " + fieldName + " in General Information")
                .located(By.xpath("(//dt[text()='" + fieldName + "']/following-sibling::dd/div)[1]"));
    }

    public static Target UPLOAD_BOL = Target.the("upload-bol")
            .locatedBy("//input[@type='file']");

    public static Target WITHDRAWAL_NUMBER = Target.the("Withdrawal request in number")
            .locatedBy("(//div[@class='title']/span)[1]");


    /**
     * Popup cancel
     */

    public static Target CANCEL_POPUP = Target.the("Popup cancel")
            .locatedBy("//div[@role='dialog']//span[text()='Cancel Withdrawal Request']");


    /**
     * Search lot code
     */

    public static Target SEARCH_LOT_RESULT(String class_, int i) {
        return Target.the("SKU information by lot code number" + i)
                .located(By.xpath("(//div[@class='el-dialog__body']//table//tbody//td[contains(@class,'" + class_ + "')])[" + i + "]"));
    }

    public static Target SEARCH_LOT_CHECKBOX(String lot, String index) {
        return Target.the("Choose lot add to withdrawal" + lot)
                .located(By.xpath("(//div[@class='el-dialog__body']//table//tbody//td[contains(text(),'" + lot + "')]/parent::tr/td[1]//span)[" + index + "]"));
    }

}
