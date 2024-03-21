package steps.api.admin.orders;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.order.DropSummaryAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DropSummaryAPIStepDefinitions {

    DropSummaryAPI dropSummaryAPI = new DropSummaryAPI();

    @And("Admin get list drop summary by API")
    public void admin_get_list_drop_summary_by_API() {
    }

    @And("Admin search sub invoice in drop summary by API")
    public void admin_search_sub_invoice_in_drop_summary_by_API(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Response response = dropSummaryAPI.callSearchSubInvoice(infos.get(0));
        Serenity.setSessionVariable("Response search sub invoice drop").to(response);
    }

    @And("Admin get sub invoice to add drop by API")
    public void admin_get_sub_invoice_in_drop_summary_by_API(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Response response = Serenity.sessionVariableCalled("Response search sub invoice drop");

    }

    @And("Admin assign po in drop by api")
    public void admin_assign_po_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> body = dropSummaryAPI.setPoInDropRequest(infos);
        // assign po
        dropSummaryAPI.callAssignPO(body);
    }

    @And("Admin create drop by API")
    public void admin_create_drop_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        RequestSpecification requestSpecification = dropSummaryAPI.setDropRequest(UrlAdminAPI.CREATE_DROP, infos);
        dropSummaryAPI.createDrop(UrlAdminAPI.CREATE_DROP, requestSpecification);
    }

    @And("Admin create drop with po by API")
    public void admin_create_drop_with_po_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> body  = dropSummaryAPI.setCreateDropWithPO(infos);
        dropSummaryAPI.callcreateDropWithPO(body);
    }

    @And("Admin search drop by order by API")
    public void admin_search_drop_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> info = new HashMap<>();
        if (infos.get(0).get("order").toString().equals("index")) {
            info.putIfAbsent("page", "1");
            info.putIfAbsent("q[number]", Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index")));
        }
        Response response = dropSummaryAPI.callSearchDrop(info);
        Serenity.setSessionVariable("Response search drop").to(response);
    }

    @And("Admin get id and number of drop index {string} by API")
    public void admin_get_id_drop_by_api(String index) {
        Response response = Serenity.sessionVariableCalled("Response search drop");
        String dropNumber = dropSummaryAPI.getNumberDrop(response);
        String dropID = dropSummaryAPI.getIDDrop(response);

        Serenity.setSessionVariable("Drop Number " + index).to(dropNumber);
        Serenity.setSessionVariable("Drop ID " + index).to(dropID);
    }


}
