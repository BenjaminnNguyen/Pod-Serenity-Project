package cucumber.user_interface.admin.financial;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CreditLimitPage {

    public static Target BUYER_COMPANY_IN_RESULT(String buyerCompany) {
        return Target.the("Buyer company credit limit in result")
                .located(By.xpath("//td[contains(@class,'buyer-company')]//span[text()='" + buyerCompany + "']"));
    }

    public static Target CREDIT_LIMIT_IN_RESULT(String buyerCompany) {
        return Target.the("Credit limit in result")
                .located(By.xpath("//span[text()='" + buyerCompany + "']//ancestor::td/following-sibling::td[contains(@class,'credit-limit')]//span"));
    }

    public static Target ENDING_BALANCE_IN_RESULT(String buyerCompany) {
        return Target.the("Ending balance in result")
                .located(By.xpath("//span[text()='" + buyerCompany + "']//ancestor::td/following-sibling::td[contains(@class,'ending-balance')]//div[@class='amount']"));
    }

    public static Target UNFULFILL_ORDER_IN_RESULT(String buyerCompany) {
        return Target.the("Unfulfill order in result")
                .located(By.xpath("//span[text()='" + buyerCompany + "']//ancestor::td/following-sibling::td[contains(@class,'unfulfilled-order')]//div[@class='amount']"));
    }

    public static Target DIFF_IN_RESULT(String buyerCompany) {
        return Target.the("Unfulfill order in result")
                .located(By.xpath("//span[text()='" + buyerCompany + "']//ancestor::td/following-sibling::td[contains(@class,'diff')]//div[@class='amount']"));
    }

    public static Target BUYER_COMPANY_IN_RESULT_EDIT(String buyerCompany) {
        return Target.the("Buyer company credit limit in result")
                .located(By.xpath("//span[@data-original-text='" + buyerCompany + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button"));
    }

    public static Target SET_CREDIT_LIMIT_POPUP(String buyerCompany) {
        return Target.the("Set credit limit popup")
                .located(By.xpath("//span[text()='Set credit limit for buyer company " + buyerCompany + "']"));
    }

    public static Target SET_CREDIT_LIMIT_TEXTBOX = Target.the("Set credit limit textbox")
            .located(By.xpath("//label[text()='Credit limit']/following-sibling::div//input"));

    /**
     * Temporary credit limit
     */

    public static Target TEMPORARY_CREDIT_LIMIT_TEXTBOX = Target.the("Temporary credit limit textbox")
            .located(By.xpath("(//label[text()='Credit limit']/following-sibling::div//input)[2]"));

    public static Target TEMPORARY_START_DATE_TEXTBOX = Target.the("Temporary start date textbox")
            .located(By.xpath("//label[text()='Start date']/following-sibling::div//input"));

    public static Target TEMPORARY_END_DATE_TEXTBOX = Target.the("Temporary end date textbox")
            .located(By.xpath("//label[text()='End date']/following-sibling::div//input"));

}
