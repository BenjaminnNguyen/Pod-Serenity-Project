package cucumber.user_interface.admin.inventory.withdrawalRequest;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class WithdrawalRequestsPage {

    public static Target CREATE_BUTTON = Target.the("create button")
            .locatedBy("//button[@class='el-button el-button--primary']");

    public static Target SKU_NAME = Target.the("SKU name")
            .locatedBy("//a[@class='sku-name']");

    public static Target DYNAMIC_INFO(String number, String info) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//td[contains(@class,'" + info + "')]"));
    }
    public static Target DYNAMIC_INFO1(String number, String info) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//td[contains(@class,'" + info + "')]//a"));
    }
    public static Target PICKUP_DATE(String number, String info) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//span[contains(@class,'" + info + "')]"));
    }
    public static Target VENDOR_COMPANY(String number, String info) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//td[contains(@class,'" + info + "')]//span"));
    }

    public static Target DYNAMIC_SEARCH(String field) {
        return Target.the(field + "information")
                .located(By.xpath("//label[contains(normalize-space(),'" + field + "')]//following-sibling::div//input"));
    }

    public static Target ETA(String number) {
        return Target.the(number + "information")
                .located(By.xpath("//a[normalize-space()='" + number + "']/ancestor::tr[contains(@class,'el-table__row')]//span[contains(@class,'eta')]"));
    }



}
