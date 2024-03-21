package steps.vendor.Inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.vendor.inventory.HandleVendorInventoryRequest;
import cucumber.tasks.vendor.inventory.HandleWithdrawalRequestVendor;
import cucumber.user_interface.beta.Vendor.inventory.VendorDisposeDonatePage;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class DisposeDonateStepDefinition {

    @And("Vendor go to dispose donate inventory page")
    public void vendor_go_to_dispose_donate_page() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.goToDisposeDonatePage()
        );
    }

    @And("Vendor go to tab {string} in dispose donate inventory page")
    public void vendor_go_to_tab_in_dispose_donate_page(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.goToTab(type)
        );
    }

    @And("Vendor go to create request dispose donate inventory")
    public void vendor_go_to_create_dispose_donate() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.goToCreateRequest()
        );
    }

    @And("Vendor fill info request dispose donate")
    public void vendor_fill_info_dispose_donate(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.fillInfoRequest(infos.get(0))
        );
    }

    @And("Vendor add inventory to request dispose")
    public void vendor_add_inventory_to_request_dispose(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.addInventory(infos)
        );
    }

    @And("Vendor edit item request dispose")
    public void vendor_edit_item_request_dispose(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.editItem(infos)
        );
    }

    @And("Vendor search value {string} and add lot to donate dispose request")
    public void vendor_search_add_lot_code_to_donate(String search, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (search.contains("index"))
            search = Serenity.sessionVariableCalled(search.split(" index ")[0]/*lotcode*/+ search.split(" index ")[1]);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.searchLot(search)
        );
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("lotCode").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_SKU_BY_LOTCODE(search)).isNotDisplayed()
                );
            else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("brand pf-ellipsis", i + 1)).text().contains(list.get(i).get("brand")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("product pf-ellipsis", i + 1)).text().contains(list.get(i).get("product")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("sku__name pf-ellipsis", i + 1)).text().contains(list.get(i).get("sku")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__value pf-break-word", i + 1)).text().contains(list.get(i).get("lotCode")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__current-qty tr", i + 1)).text().contains(list.get(i).get("currentQty")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__end-qty tr", i + 1)).text().contains(list.get(i).get("endQty")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__pulled-qty tr", i + 1)).text().contains(list.get(i).get("pulledQty")),
                        Scroll.to(VendorWithdrawalRequestPage.SEARCH_VALUE_LOT(list.get(i).get("lotCode"))),
                        Click.on(VendorWithdrawalRequestPage.SEARCH_VALUE_LOT(list.get(i).get("lotCode"))),
                        Ensure.that(VendorWithdrawalRequestPage.ADD_SELECTED_LOT).text().contains("Add \n" + (i + 1) + " \nselected lot")
                );
                if (i == list.size() - 1)
                    theActorInTheSpotlight().attemptsTo(
                            Click.on(VendorWithdrawalRequestPage.ADD_SELECTED_LOT)
                    );
            }
        }

    }

    @And("Vendor remove sku with lot code to donate dispose request")
    public void vendor_remove_lotcode_to_donate(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "lotCode", map.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + map.get("sku") + map.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.removeLotCode(info.get("lotCode"))
            );
        }
    }

    @And("Vendor create request dispose success")
    public void vendor_add_inventory_to_request_dispose_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.addInventorySuccess()
        );
    }

    @And("Vendor verify information of request dispose detail")
    public void vendor_verify_information_of_request_dispose_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.REQUEST_STATUS),
                Ensure.that(VendorDisposeDonatePage.REQUEST_STATUS).text().contains(infos.get(0).get("status")),
                Ensure.that(VendorDisposeDonatePage.DISPOSE_OR_DONATE_TEXTBOX).attribute("value").contains(infos.get(0).get("type")),
                Ensure.that(VendorDisposeDonatePage.REGION_TEXTBOX).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(VendorDisposeDonatePage.COMMENT_TEXTBOX).attribute("value").contains(infos.get(0).get("comment"))
        );
    }

    @And("Vendor check fee apply of request donate dispose")
    public void vendor_check_fee_of_request_dispose_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        if (infos.get(0).containsKey("feeDonation")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorDisposeDonatePage.FEE_DONATION).text().contains(infos.get(0).get("feeDonation"))
            );
        }
        if (infos.get(0).containsKey("feeDisposal")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorDisposeDonatePage.FEE_DISPOSAL).text().contains(infos.get(0).get("feeDisposal"))
            );
        }
    }

    @And("Vendor get number dispose donate request")
    public void vendor_get_number_dispose_donate_request() {
        // get number of request
        String number = Text.of(VendorDisposeDonatePage.REQUEST_NUMBER).answeredBy(theActorInTheSpotlight()).toString();
        number = number.substring(9);
        Serenity.setSessionVariable("Request Dispose Donate Number").to(number);
    }

    @And("Vendor verify detail inventory of request dispose detail")
    public void vendor_verify_detail_inventory_of_request_dispose_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorDisposeDonatePage.REQUEST_STATUS),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_PRODUCT(temp.get("lotCode"))).text().contains(temp.get("product")),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_BRAND(temp.get("lotCode"))).text().contains(temp.get("brand")),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_SKU(temp.get("lotCode"))).text().contains(temp.get("sku")),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_SKU_ID(temp.get("lotCode"))).text().contains(temp.get("skuID")),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_EXPIRY_DATE(temp.get("lotCode"))).text().contains(CommonHandle.setDate2(temp.get("expiryDate"), "MM/dd/yy")),
                    Check.whether(temp.get("pullDate").equals(""))
                            .otherwise(Ensure.that(VendorDisposeDonatePage.INVENTORY_PULL_DATE(temp.get("lotCode"))).text().contains(CommonHandle.setDate2(temp.get("pullDate"), "MM/dd/yy"))),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_OF_CASE_TEXTBOX(temp.get("lotCode"))).attribute("value").contains(temp.get("ofCase")),
                    Ensure.that(VendorDisposeDonatePage.INVENTORY_MAX_CASE_TEXTBOX(temp.get("lotCode"))).text().contains(temp.get("max"))
            );
        }

    }

    @And("Vendor verify inventory request")
    public void vendor_verify_inventory_request(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("number"), Serenity.sessionVariableCalled("Request Dispose Donate Number"), "random");
        info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Inventory Request Number API"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.RESULT_VALUE("number")),
                Ensure.that(VendorDisposeDonatePage.RESULT_VALUE("number")).text().contains(info.get("number")),
                Ensure.that(VendorDisposeDonatePage.RESULT_VALUE("date")).text().contains(CommonHandle.setDate2(info.get("requestDate"), "MM/dd/yy")),
                Ensure.that(VendorDisposeDonatePage.RESULT_VALUE("type")).text().contains(info.get("type")),
                Ensure.that(VendorDisposeDonatePage.RESULT_VALUE("case")).text().contains(info.get("case")),
                Ensure.that(VendorDisposeDonatePage.RESULT_VALUE("status")).text().contains(info.get("status"))
        );
    }

    @And("Vendor verify inventory request number {string} not show on list")
    public void vendor_verify_inventory_request_not_show(String number) {
        if (number.contains("random"))
            number = Serenity.sessionVariableCalled("Request Dispose Donate Number");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorDisposeDonatePage.RESULT_NUMBER(number)).isNotDisplayed()
        );
    }

    @And("Vendor go to detail inventory request {string}")
    public void vendor_go_to_detail_inventory_request(String number) {
        if (number.contains("create by admin")) {
            number = Serenity.sessionVariableCalled("Request Dispose Donate Number");
        }
        if (number.contains("create by api")) {
            number = Serenity.sessionVariableCalled("Inventory Request Number API");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleVendorInventoryRequest.goToDetail(number)
        );
    }

}
