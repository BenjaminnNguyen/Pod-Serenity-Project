package cucumber.user_interface.admin.inventory.withdrawalRequest;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CreateWithdrawalRequestsPage {

    public static Target CREATE_BUTTON = Target.the("create button")
            .locatedBy("//span[normalize-space()='Create']");

    public static Target CANCEL_BUTTON(String number) {
        return Target.the("Cancel withdrawal requests button")
                .locatedBy("//a[contains(text(),'" + number + "')]/ancestor::tr//span[contains(text(),'Cancel')]");
    }

    public static Target TITLE = Target.the("Get number")
            .locatedBy("(//div[@class='title']/span)[1]");

    public static Target SELF_PICKUP = Target.the("self pickup")
            .locatedBy("//span[normalize-space()='Self pickup']");

    public static Target CARRIER_PICKUP = Target.the("carrier pickup")
            .locatedBy("//span[normalize-space()='Carrier pickup']");

    public static Target ADD_LOT_CODE_BUTTON = Target.the("Add lot code")
            .locatedBy("//span[contains(text(),'Add lot code')]");

    public static Target ADD_LOT_CODE_BUTTON_IN_POPUP = Target.the("Add lot code")
            .locatedBy("//button//span[text()='Add']");

    public static Target SEARCH_LOT_CODE_BUTTON = Target.the("search lot code")
            .locatedBy("//span[contains(text(),'Search')]");

    public static Target FIRST_LOT_CODE = Target.the("first lot")
            .locatedBy("//td[@class='sku-name tl']/preceding-sibling::td[@class='section']");

    public static Target LOT_CODE_IN_ADD(String lotCode) {
        return Target.the("Lot code in add lot code")
                .locatedBy("//div[@role='dialog']//td[text()='" + lotCode + "']");
    }

    public static Target FIRST_LOT_CODE_QTY = Target.the("first lot quantity")
            .locatedBy("//td[@class='end-qty']");

    public static Target FIRST_LOT_CODE_CASE = Target.the("first lot")
            .locatedBy("//div[@class='el-input el-input--small']//input[@type='number']");

    public static Target LOT_CODE_CHECKBOX(String info) {
        return Target.the("lot code")
                .located(By.xpath("//td[contains(text(),'" + info + "')]/preceding-sibling::td[@class='section']"));
    }

    public static Target LOT_CODE_QTY(String info) {
        return Target.the("lot code quantity")
                .located(By.xpath("//*[contains(text(),'" + info + "')]/parent::td/following-sibling::td[@class='end-qty']"));
    }

    public static Target CASES(String lot) {
        return Target.the("case lot code")
                .located(By.xpath("//*[normalize-space()='" + lot + "']/parent::td/following-sibling::td[@class='case']//input"));
    }

    public static Target CASES_VERIRY = Target.the("Case lot code")
            .located(By.xpath("//td[@class='case']//input"));

    public static Target CASES_ERROR = Target.the("Case lot code message error")
            .located(By.xpath("//td[@class='case']//div[contains(@class,'item__error')]"));

    public static Target PALLET_ERROR = Target.the("Pallet weight message error")
            .located(By.xpath("//label[@for='pallet_weight']/following-sibling::div//div[contains(@class,'item__error')]"));

    public static Target DELETE_LOTCODE(String lot) {
        return Target.the("Delete lot code")
                .located(By.xpath("//*[normalize-space()='" + lot + "']/parent::td/following-sibling::td[@class='action']//button"));
    }

    public static Target DYNAMIC_INFO(String info) {
        return Target.the("information")
                .located(By.xpath("//div[contains(@class,'" + info + "')]//input"));
    }

    public static Target DYNAMIC_INFO_ERROR(String title) {
        return Target.the("Information of " + title + " error")
                .located(By.xpath("//label[contains(text(),'" + title + "')]/following-sibling::div//div[contains(@class,'error')]"));
    }

    public static Target D_ADD_LOTCODE(String field) {
        return Target.the(field + "information")
                .located(By.xpath("//div[@role='dialog']//label[contains(normalize-space(),'" + field + "')]//following-sibling::div//input"));
    }



}
