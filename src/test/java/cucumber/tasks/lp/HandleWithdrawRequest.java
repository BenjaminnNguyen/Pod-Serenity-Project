package cucumber.tasks.lp;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.lp.LPWithdrawalRequestPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleWithdrawRequest {

    public static Task search(Map<String, String> list) {
        return Task.where("",
                Check.whether(!list.get("number").isEmpty()).andIfSo(
                        Enter.theValue(list.get("number")).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Number")).thenHit(Keys.TAB)
                ).otherwise(
                        Check.whether(Serenity.hasASessionVariableCalled("Withdrawal Request Number")).andIfSo(
                                Enter.theValue(Serenity.sessionVariableCalled("Withdrawal Request Number").toString()).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Number")).thenHit(Keys.TAB)
                        )
                ),
                Check.whether(!list.get("vendorCompany").isEmpty()).andIfSo(
                        Enter.theValue(list.get("vendorCompany")).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Vendor Company")).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("brand").isEmpty()).andIfSo(
                        Enter.theValue(list.get("brand")).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Brand")).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("region").isEmpty()).andIfSo(
                        Enter.theValue(list.get("region")).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Region")).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("from").isEmpty()).andIfSo(
                        Enter.theValue(list.get("from")).into(LPWithdrawalRequestPage.DYNAMIC_SEARCH("Requested (from)")).thenHit(Keys.TAB)
                ),
                CommonWaitUntil.isNotVisible(LPWithdrawalRequestPage.LOADING)
        );

    }

//    public static Task goToDetail(String number) {
//        if (number.isEmpty()) {
//            return Task.where("",
//                    CommonWaitUntil.isVisible(InboundInventoryLPPage.TABLE_NUMBER(Serenity.sessionVariableCalled("Inventory_Reference").toString())),
//                    Click.on(InboundInventoryLPPage.TABLE_NUMBER(Serenity.sessionVariableCalled("Inventory_Reference").toString())),
//                    CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
//            );
//        } else {
//            return Task.where("",
//                    CommonWaitUntil.isVisible(InboundInventoryLPPage.TABLE_NUMBER(number)),
//                    Click.on(InboundInventoryLPPage.TABLE_NUMBER(number)),
//                    CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
//            );
//        }
//    }
}
