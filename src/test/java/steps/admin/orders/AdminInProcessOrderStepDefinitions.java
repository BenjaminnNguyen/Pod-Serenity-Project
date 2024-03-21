package steps.admin.orders;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleInprocessOrders;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.InprocessOrderPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminInProcessOrderStepDefinitions {

    @And("Admin search the in-process orders by info")
    public void search_the_in_process_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("orderNumber").isEmpty()) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(7);
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "");
        }
        if (infos.get(0).get("orderNumber").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("orderNumber").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");
        }
        if (infos.get(0).get("orderNumber").contains("empty")) {
            idInvoice = "";
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "empty");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleInprocessOrders.checkByInfo(info)
        );
    }

    @And("Admin verify result order in in-process order")
    public void verify_result_order_in_all_order(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String idInvoice = null;
        HashMap<String, String> info = new HashMap<>();
        if (expected.get(0).get("order").equals("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice, "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(InprocessOrderPage.ORDER_RESULT).text().contains(info.get("order")),
                Ensure.that(InprocessOrderPage.CUSTOMER_PO_RESULT).text().contains(info.get("customerPO")),
                Ensure.that(InprocessOrderPage.CREATOR_RESULT).text().contains(info.get("creator")),
                Ensure.that(InprocessOrderPage.STATUS_RESULT).text().contains(info.get("status")),
                Ensure.that(InprocessOrderPage.BUYER_RESULT).attribute("data-original-text").contains(info.get("buyer")),
                Ensure.that(InprocessOrderPage.REGION_RESULT).text().contains(info.get("region"))

        );
    }

    @And("Admin go to detail in process order after search")
    public void admin_go_to_detail_after_search() {
        String idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.seeDetail(idInvoice)
        );
    }
}
