package steps.lp.inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.lp.inventory.HandleDisposeDonateInventoryLP;
import cucumber.tasks.lp.inventory.HandleIncomingInventoryLP;
import cucumber.tasks.lp.inventory.HandleWithdrawalRequestsLP;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import cucumber.user_interface.lp.inventory.WithdrawalRequestLPPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.af.En;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Upload;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class DisposeDonateStepDefinitions {

    @And("LP search {string} dispose donate inventory")
    public void lp_search_dispose_requests(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(InventoryLPPage.D_TAB(type)),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Fetching your"))
        );
        for (Map<String, String> item : list) {
            if (item.get("number").contains("create by api"))
                item = CommonTask.setValue(item, "number", item.get("number"), Serenity.sessionVariableCalled("Inventory Request Number API"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    HandleDisposeDonateInventoryLP.search(item)
            );
        }
    }

    @And("LP verify result Dispose Donate inventory after search")
    public void lp_verify_dispose_requests(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (Map<String, String> item : expected) {
            if (item.get("number").contains("create by api"))
                item = CommonTask.setValue(item, "number", item.get("number"), Serenity.sessionVariableCalled("Inventory Request Number API"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_INFO(item.get("number"), "brand")).text().contains(item.get("brand")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_INFO(item.get("number"), "type")).text().contains(item.get("type")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_INFO(item.get("number"), "status")).text().contains(item.get("status"))
            );
        }
    }

    @And("LP search dispose donate with all filter")
    public void search_order_all_filter(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDisposeDonateInventoryLP.searchAll()
        );
        for (Map<String, String> info : list) {
            if (list.get(0).get("number").contains("create by api"))
                info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Inventory Request Number API").toString(), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    HandleDisposeDonateInventoryLP.inputSearchAll(info)
            );
        }
    }

    @And("LP clear search all filters donate")
    public void clear_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleDisposeDonateInventoryLP.clearSearchAll()
        );
    }

    @And("LP close search all filters donate")
    public void close_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleDisposeDonateInventoryLP.closeSearchAll()
        );
    }


    @And("LP go to details dispose donate request {string}")
    public void lp_detail_dispose_requests(String numberRequest) {
        if (numberRequest.equals("create by api"))
            numberRequest = Serenity.sessionVariableCalled("Inventory Request Number API");
        theActorInTheSpotlight().attemptsTo(
                HandleDisposeDonateInventoryLP.goToDetail(numberRequest)
        );
    }

    @And("LP verify details dispose donate request")
    public void lp_detail_dispose_requests(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String number = list.get(0).get("number");
        if (list.get(0).get("number").equals("create by api"))
            number = Serenity.sessionVariableCalled("Inventory Request Number API").toString();
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(WithdrawalRequestLPPage.DISPOSE_REQUEST_NUMBER),
                Ensure.that(WithdrawalRequestLPPage.DISPOSE_REQUEST_NUMBER).text().contains("Request #" + number),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_INFO("requested-date")).text().contains(CommonHandle.setDate2(list.get(0).get("requestDate"), "MM/dd/yy")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_INFO("fulfillment")).text().contains(list.get(0).get("status")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_GENERAL_INFO("Region")).text().contains(list.get(0).get("region")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_GENERAL_INFO("Vendor company")).text().contains(list.get(0).get("vendorCompany")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_GENERAL_INFO("Request type")).text().contains(list.get(0).get("type")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_GENERAL_INFO("Request date")).text().contains(CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_DETAIL_GENERAL_INFO("Documents")).text().contains(list.get(0).get("document"))
        );
    }

    @And("LP verify items detail dispose donate request")
    public void lp_item_detail_dispose_requests(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            String id = map.get("skuID");
            if (map.get("skuID").contains("create by api"))
                id = Serenity.sessionVariableCalled("itemCode" + map.get("sku")).toString();
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "brand")).text().contains(map.get("brand")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "product")).text().contains(map.get("product")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "variant")).text().contains(map.get("sku")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "variant__id")).text().contains(id),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "contain")).attribute("style").contains(map.get("image")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "lot__expiry")).text().contains(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "lot__pull")).text().contains(CommonHandle.setDate2(map.get("pullDate"), "MM/dd/yy")),
                    Ensure.that(WithdrawalRequestLPPage.DONATE_INVENTORY_ITEMS(map.get("lotcode"), "lot__quantity")).text().contains(map.get("cases"))
            );
        }
    }

    @And("LP mark complete dispose donate request")
    public void lp_complete_dispose_requests() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Mark complete")),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_ALERT("Updated successfully.")),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Updated successfully.")),
                WindowTask.threadSleep(3000)
        );
    }

    @And("LP add documents to dispose donate request")
    public void lp_add_documents_dispose_requests(List<String> files) {
        for (String file : files)
            theActorInTheSpotlight().attemptsTo(
                    CommonFile.upload(file, CommonLPPage.FILE),
                    CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_ALERT("Updated successfully.")),
                    CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Updated successfully."))
            );
    }
}
