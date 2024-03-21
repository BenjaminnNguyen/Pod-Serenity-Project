package steps.flowspace;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.flowspace.outboundOrders.HandleFSOutboundOrders;
import cucumber.user_interface.flowspace.FSOutboundOrdersPage;
import cucumber.user_interface.flowspace.FSOutboundOrderDetailPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class FSOutboundOrdersStepDefinitions {

    @And("FS search the orders in outbound orders by info")
    public void search_the_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));

        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.search(info)
        );
    }

    @And("FS verify drop in outbound orders by info")
    public void verify_drop_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        for (Map<String, String> temp : infos) {
            Serenity.setSessionVariable("Drop number by api").to("23113095522");
            String dropNumber = Serenity.sessionVariableCalled("Drop number by api").toString();
            info = CommonTask.setValue(temp, "dropNumber", temp.get("dropNumber"), dropNumber, "create by api");
            // Verify
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(FSOutboundOrdersPage.DROP_NUMBER_IN_LIST(info.get("dropNumber"))),
                    Ensure.that(FSOutboundOrdersPage.DROP_NUMBER_IN_LIST(info.get("dropNumber"))).text().contains(info.get("dropNumber")),
                    Ensure.that(FSOutboundOrdersPage.DEPARTURE_IN_LIST(info.get("dropNumber"))).text().contains(CommonHandle.setDate2(info.get("departure"), "MM/dd/yyyy")),
                    Ensure.that(FSOutboundOrdersPage.CUSTOMER_IN_LIST(info.get("dropNumber"))).text().contains(info.get("customer")),
                    Ensure.that(FSOutboundOrdersPage.MODE_IN_LIST(info.get("dropNumber"))).text().contains(info.get("mode")),
                    Ensure.that(FSOutboundOrdersPage.TAG_IN_LIST(info.get("dropNumber"))).attribute("data-content").contains(info.get("tag")),
                    Ensure.that(FSOutboundOrdersPage.STATUS_IN_LIST(info.get("dropNumber"))).text().contains(info.get("status")),
                    Ensure.that(FSOutboundOrdersPage.FROM_IN_LIST(info.get("dropNumber"))).text().contains(info.get("from")),
                    Ensure.that(FSOutboundOrdersPage.FROM_ADDRESS_IN_LIST(info.get("dropNumber"))).text().contains(info.get("fromAddress")),
                    Ensure.that(FSOutboundOrdersPage.TO_IN_LIST(info.get("dropNumber"))).text().contains(info.get("to")),
                    Ensure.that(FSOutboundOrdersPage.TO_ADDRESS_IN_LIST(info.get("dropNumber"))).text().contains(info.get("toAddress")),
                    Check.whether(info.get("shipped").isEmpty())
                            .otherwise(Ensure.that(FSOutboundOrdersPage.SHIPPED_IN_LIST(info.get("dropNumber"))).text().contains(info.get("shipped"))),
                    Ensure.that(FSOutboundOrdersPage.SKU_COUNT_IN_LIST(info.get("dropNumber"))).text().contains(info.get("skuCount")),
                    Ensure.that(FSOutboundOrdersPage.ITEM_COUNT_IN_LIST(info.get("dropNumber"))).text().contains(info.get("itemCount"))
            );
        }
    }

    @And("FS go to detail drop {string} in outbound orders by info")
    public void go_to_detail_the_order_by_info(String dropNumber) {
        if (dropNumber.equals("create by api")) {
            dropNumber = Serenity.sessionVariableCalled("Drop number by api").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.goToDetail(dropNumber)
        );
    }

    @And("FS verify info of outbound order detail")
    public void verify_info_of_the_outbound_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        if (info.get("dropNumber").equals("create by api")) {
            info = CommonTask.setValue(info, "dropNumber", info.get("dropNumber"), Serenity.sessionVariableCalled("Drop number by api").toString(), "create by api");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(FSOutboundOrderDetailPage.PO_NUMBER_DETAIL),
                Ensure.that(FSOutboundOrderDetailPage.CUSTOMER_DETAIL).text().contains(info.get("customer")),
                Ensure.that(FSOutboundOrderDetailPage.WAREHOUSE_DETAIL).text().contains(info.get("warehouse")),
                Ensure.that(FSOutboundOrderDetailPage.PO_NUMBER_DETAIL).text().contains(info.get("dropNumber")),
                Ensure.that(FSOutboundOrderDetailPage.ITEMS_ORDERED_DETAIL).text().contains(info.get("itemOrdered")),
                Ensure.that(FSOutboundOrderDetailPage.CREATION_SOURCE_DETAIL).text().contains(info.get("creationSource"))
        );
    }

    @And("FS verify info of sku in outbound order detail")
    public void verify_info_of_sku_outbound_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(FSOutboundOrderDetailPage.SKU_ID_DETAIL(info.get("skuID"))),
                    Ensure.that(FSOutboundOrderDetailPage.SKU_ID_DETAIL(info.get("skuID"))).text().contains(info.get("skuID")),
                    Ensure.that(FSOutboundOrderDetailPage.UPC_SKU_DETAIL(info.get("skuID"))).text().contains(info.get("upc")),
                    Ensure.that(FSOutboundOrderDetailPage.DESCRIPTION_SKU_DETAIL(info.get("skuID"))).text().contains(info.get("description")),
                    Ensure.that(FSOutboundOrderDetailPage.ORDERED_SKU_DETAIL(info.get("skuID"))).text().contains(info.get("ordered"))
            );
        }
    }

    @And("FS change to role {string}")
    public void fs_change_to_role(String role) {
        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.changeRole(role)
        );
    }

    @And("FS picking this drop")
    public void fs_picking() {
        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.picking()
        );
    }

    @And("FS pack this drop")
    public void fs_begin_picking(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.pack(infos.get(0))
        );
    }

    @And("FS ship this drop")
    public void fs_ship(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleFSOutboundOrders.ship(infos.get(0))
        );
    }

}
