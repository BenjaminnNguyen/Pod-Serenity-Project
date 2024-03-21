package cucumber.tasks.lp.inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.OrdersLPPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import cucumber.user_interface.lp.inventory.WithdrawalRequestLPPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleWithdrawalRequestsLP {

    public static Task search(Map<String, String> info) {
        return Task.where("",
                Check.whether(!info.get("number").isEmpty()).andIfSo(
                        Enter.theValue(info.get("number")).into(WithdrawalRequestLPPage.D_FIELD_SEARCH("Number"))
                ),
                Check.whether(!info.get("vendorCompany").isEmpty()).andIfSo(
                        Enter.theValue(info.get("vendorCompany")).into(WithdrawalRequestLPPage.D_FIELD_SEARCH("Vendor Company"))
                ),
                Check.whether(!info.get("brand").isEmpty()).andIfSo(
                        CommonTask.chooseItemInDropdownWithValueInput(WithdrawalRequestLPPage.D_FIELD_SEARCH("Brand"), info.get("brand"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(info.get("brand")))
                ),
                Check.whether(!info.get("region").isEmpty()).andIfSo(
                        CommonTask.chooseItemInDropdownWithValueInput(WithdrawalRequestLPPage.D_FIELD_SEARCH("Region"), info.get("region"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(info.get("region")))
                ),
                Check.whether(!info.get("request").isEmpty()).andIfSo(
                        Enter.theValue(CommonHandle.setDate2(info.get("request"),"MM/dd/yy")).into(WithdrawalRequestLPPage.D_FIELD_SEARCH("Requested (from)")).thenHit(Keys.ENTER)
                ),
                CommonWaitUntil.isNotVisible(InventoryLPPage.LOADING)
        );

    }

    public static Task goToDetail(String numberRequest) {
        return Task.where("Go to detail withdrawal request",
                CommonWaitUntil.isVisible(WithdrawalRequestLPPage.NUMBER_RESULT(numberRequest)),
                Click.on(WithdrawalRequestLPPage.NUMBER_RESULT(numberRequest)),
                CommonWaitUntil.isNotVisible(WithdrawalRequestLPPage.LOADING_ICON));
    }

    public static Task updateSuccess() {
        return Task.where("Update success",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("UPDATE")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("UPDATE")),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_ALERT("Withdrawal inventory updated successfully.")),
                Click.on(CommonLPPage.ICON_CIRCLE_DELETE1),
                CommonWaitUntil.isVisible(WithdrawalRequestLPPage.REQUEST_HEADER_DETAIL)
        );
    }

    public static Task searchAll() {
        return Task.where("Open search all order",
                CommonWaitUntil.isVisible(CommonLPPage.ALL_FILTER),
                Click.on(CommonLPPage.ALL_FILTER),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number"))
        );
    }

    public static Task inputSearchAll(Map<String, String> map) {
        return Task.where("search all order",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number")),
                Check.whether(map.get("number").isEmpty()).otherwise(
                        Enter.theValue(map.get("number")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                ),
                Check.whether(map.get("vendorCompany").isEmpty()).otherwise(
                        Enter.theValue(map.get("vendorCompany")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Vendor Company")),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Brand"), map.get("brand"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("brand"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                ),
                Check.whether(map.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Region"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("region"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                ),
                Check.whether(map.get("requestFrom").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("requestFrom"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Requested (from)")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                ),
                Check.whether(map.get("requestTo").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("requestTo"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Requested (to)")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your withdrawal"))
                )
        );
    }

    public static Task closeSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(OrdersLPPage.CLOSE_SEARCH_ALL),
                Click.on(OrdersLPPage.CLOSE_SEARCH_ALL),
                CommonWaitUntil.isNotVisible(OrdersLPPage.CLOSE_SEARCH_ALL)
        );
    }

    public static Task clearSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Clear all filters")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Clear all filters"))
        );
    }

}
