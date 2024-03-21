package steps.lp.inventory;

import io.cucumber.java.en.*;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.lp.inventory.HandleIncomingInventoryLP;
import cucumber.tasks.lp.inventory.HandleWithdrawalRequestsLP;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import cucumber.user_interface.lp.inventory.WithdrawalRequestLPPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class WithdrawalRequestsStepDefinitions {

    @And("LP search {string} withdrawal requests")
    public void lp_search_withdrawal_requests(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(InventoryLPPage.D_TAB(type)),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Fetching your"))
        );

        for (Map<String, String> item : list) {
            if (item.containsKey("index")) {
                HashMap<String, String> info = CommonTask.setValueRandom(item, "number", Serenity.sessionVariableCalled("Withdrawal Request Number"));
                info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api" + item.containsKey("index")), "create by api");
                theActorInTheSpotlight().attemptsTo(
                        HandleWithdrawalRequestsLP.search(info)
                );
            } else {
                HashMap<String, String> info = CommonTask.setValueRandom(item, "number", Serenity.sessionVariableCalled("Withdrawal Request Number"));
                info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api"), "create by api");
                theActorInTheSpotlight().attemptsTo(
                        HandleWithdrawalRequestsLP.search(info)
                );
            }
        }
    }

    @And("LP verify result withdrawal requests after search")
    public void lp_verify_withdrawal_requests(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (expected.size() > 1) {
            for (Map<String, String> item : expected) {
                if (item.containsKey("index")) {
                    HashMap<String, String> info = CommonTask.setValue(item, "number", item.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api" + item.get("index")), "create by api");
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(WithdrawalRequestLPPage.NUMBER_RESULT(info.get("number"))).isDisplayed(),
                            Ensure.that(WithdrawalRequestLPPage.BRAND_RESULT(info.get("number"))).text().contains(info.get("brand")),
                            Ensure.that(WithdrawalRequestLPPage.PICKUPDATE_RESULT(info.get("number"))).text().contains(CommonHandle.setDate2(info.get("pickupDate"), "MM/dd/yy")),
                            Ensure.that(WithdrawalRequestLPPage.STATUS_RESULT(info.get("number"))).text().contains(info.get("status"))
                    );
                }
            }
        } else {
            for (Map<String, String> item : expected) {
                HashMap<String, String> info = CommonTask.setValueRandom(item, "number", Serenity.sessionVariableCalled("Withdrawal Request Number"));
                info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api"), "create by api");
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestLPPage.NUMBER_RESULT(info.get("number"))).isDisplayed(),
                        Ensure.that(WithdrawalRequestLPPage.BRAND_RESULT(info.get("number"))).text().contains(info.get("brand")),
                        Ensure.that(WithdrawalRequestLPPage.PICKUPDATE_RESULT(info.get("number"))).text().contains(CommonHandle.setDate2(info.get("pickupDate"), "MM/dd/yy")),
                        Ensure.that(WithdrawalRequestLPPage.STATUS_RESULT(info.get("number"))).text().contains(info.get("status"))
                );
            }
        }

    }

    @And("LP go to details withdrawal requests {string}")
    public void lp_search_withdrawal_requests(String numberRequest) {
        if (numberRequest.equals("")) {
            numberRequest = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }
        if (numberRequest.equals("create by api"))
            numberRequest = Serenity.sessionVariableCalled("Number Withdraw request api");
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestsLP.goToDetail(numberRequest)
        );
    }

    @And("LP verify pickup information in withdrawal requests detail")
    public void lp_verify_pickup_information_in_withdrawal_requests_details(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (Map<String, String> item : expected) {
            HashMap<String, String> info = CommonTask.setValueRandom(item, "number", Serenity.sessionVariableCalled("Withdrawal Request Number"));
            info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestLPPage.REQUEST_HEADER_DETAIL).text().contains(info.get("number")),
                    Ensure.that(WithdrawalRequestLPPage.STATUS_DETAIL).text().contains(info.get("status")),
                    Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup date")).attribute("value").contains(CommonHandle.setDate2(item.get("pickupDate"), "MM/dd/yy")),
                    Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup time (Start)")).attribute("value").contains(item.get("startTime")),
                    Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup time (End)")).attribute("value").contains(item.get("endTime")),
                    Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup region")).attribute("value").contains(item.get("region")),
                    Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Are you using a freight carrier?")).attribute("value").contains(item.get("useFreight"))

            );
            if (item.containsKey("nameContact")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Name of contact")).attribute("value").contains(item.get("nameContact"))
                );
            }
            if (item.containsKey("carrier")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Carrier")).attribute("value").contains(item.get("carrier"))
                );
            }
            if (item.containsKey("bol")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_BOL_DETAIL("BOL")).text().contains(item.get("bol"))
                );
            }
        }
    }

    @And("LP verify withdrawal details in withdrawal requests detail")
    public void lp_verify_withdrawal_details_in_withdrawal_requests_details(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> item : list) {
            info = CommonTask.setValue(item, "sku", item.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")));

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestLPPage.D_BRAND_DETAILS(info.get("lotCode"))).text().contains(info.get("brand")),
                    Ensure.that(WithdrawalRequestLPPage.D_PRODUCT_DETAILS(info.get("lotCode"))).text().contains(info.get("product")),
                    Ensure.that(WithdrawalRequestLPPage.D_SKU_DETAILS(info.get("lotCode"))).text().contains(info.get("sku")),
                    Ensure.that(WithdrawalRequestLPPage.D_LOTCODE_DETAILS(info.get("lotCode"))).text().contains(info.get("lotCode")),
                    Ensure.that(WithdrawalRequestLPPage.D_QUANTITY_DETAILS(info.get("lotCode"))).attribute("value").contains(info.get("quantity")),
                    Check.whether(info.get("expiryDate").equals(""))
                            .otherwise(Ensure.that(WithdrawalRequestLPPage.D_EXPIRY_DATE_DETAILS(info.get("lotCode"))).attribute("value").contains(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy"))),
                    Check.whether(info.get("pallet").equals(""))
                            .otherwise(Ensure.that(WithdrawalRequestLPPage.PALLET_TEXTBOX).attribute("value").contains(info.get("pallet"))),
                    Check.whether(info.get("comment").equals(""))
                            .otherwise(Ensure.that(WithdrawalRequestLPPage.COMMENT_TEXTBOX).attribute("value").contains(info.get("comment")))
            );
        }
    }

    @And("LP verify no found result withdrawal requests after search")
    public void lp_verify_no_found_withdrawal_requests() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(WithdrawalRequestLPPage.NO_FOUND_RESULT).isDisplayed()
        );
    }

    @And("LP edit field in withdrawal requests detail")
    public void lp_edit_field_in_withdrawal_requests_details(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                // Edit Pickup date blank
                MoveMouse.to(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup date")),
                Click.on(CommonLPPage.ICON_CIRCLE_DELETE),
                CommonWaitUntil.isVisible(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL_ERROR("Pickup date")),
                Ensure.that(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL_ERROR("Pickup date")).text().contains("Please enter pickup date"),
                // Choose Pickup date
                Check.whether(expected.get(0).get("pickupDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(expected.get(0).get("pickupDate"), "MM/dd/yy")).into(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup date")).thenHit(Keys.ENTER)
                ),
                // Edit Pickup time (Start)
                Check.whether(expected.get(0).get("startTime").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup time (Start)"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(expected.get(0).get("startTime")))
                ),
                // Edit Pickup time (End)
                WindowTask.threadSleep(1000),
                Check.whether(expected.get(0).get("endTime").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(WithdrawalRequestLPPage.D_TEXTBOX_DETAIL("Pickup time (End)"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(expected.get(0).get("endTime")))
                )
        );
    }

    @And("LP update success withdrawal request")
    public void lp_update_success_withdrawal_request() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestsLP.updateSuccess()
        );
    }

    @And("LP search withdrawal request with all filter")
    public void search_withdrawal_all_filter(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestsLP.searchAll()
        );
        HashMap<String, String> info = new HashMap<String, String>(list.get(0));
        if (list.get(0).get("number").contains("create by api"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Number Withdraw request api").toString(), "create by api");
        if (list.get(0).get("number").contains("create by vendor"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Withdrawal Request Number").toString(), "create by vendor");
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestsLP.inputSearchAll(info)
        );
    }

    @And("LP clear search all filters withdrawal")
    public void clear_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.clearSearchAll()
        );
    }

    @And("LP close search all filters withdrawal")
    public void close_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.closeSearchAll()
        );
    }

    @And("LP complete withdrawal request in detail")
    public void complete_withdrawal_request_in_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.completeWithdrawal()
        );
    }

}
