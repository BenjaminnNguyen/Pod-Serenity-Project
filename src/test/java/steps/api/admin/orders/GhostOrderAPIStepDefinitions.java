package steps.api.admin.orders;

import cucumber.models.api.admin.orders.CreateGhostOrder;
import cucumber.models.api.admin.orders.GhostLineItemsAttributes;
import cucumber.models.api.admin.orders.LineItemsAttributes;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.order.GhostOrderAdminApi;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GhostOrderAPIStepDefinitions {

    GhostOrderAdminApi ghostOrderAdminApi = new GhostOrderAdminApi();

    @And("Admin create line items attributes by API of ghost order")
    public void createLineItemsAttributes2(List<LineItemsAttributes> itemsAttributes) {
        Serenity.setSessionVariable("List items order API").to(itemsAttributes);
    }

    @And("Admin create ghost order line items attributes by API")
    public void createGhostOrderLineItemsAttributes(List<GhostLineItemsAttributes> ghostLineItemsAttributes) {
        Serenity.setSessionVariable("List ghost order line item API").to(ghostLineItemsAttributes);
    }

    @And("Admin create ghost order by API")
    public void createGhostOrder(DataTable dt) {
        // set request body
        CreateGhostOrder createGhostOrder = ghostOrderAdminApi.setCreateGhostOrderModel(dt);
        // send request
        Response response = ghostOrderAdminApi.createGhostOrder(createGhostOrder);
        // lưu ID ghost order
        String idGhostOrder = ghostOrderAdminApi.getIdGhostOrderCreated(response);
        Serenity.setSessionVariable("Ghost Order ID API").to(idGhostOrder);
        // lưu number ghost order
        String ghostOrderNumber = ghostOrderAdminApi.getNumberGhostOrderCreated(response);
        Serenity.setSessionVariable("Ghost Order Number API").to(ghostOrderNumber);
    }

    @And("Search ghost order by api")
    public void search_ghost_order_by_skuname(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Response response = ghostOrderAdminApi.callSearchGhostOrder(infos.get(0));
        ghostOrderAdminApi.getListIdGhostOrder(response);
    }

    @And("Convert to real order of ghost order {string} by API")
    public void convert_ghost_to_order_by_api(String ghostOrderID, DataTable dt) {
        if(ghostOrderID.equals("API")) {
            ghostOrderID = Serenity.sessionVariableCalled("ID ghost order created by API");
        }
        List<Map<String, String>> data = dt.asMaps(String.class, String.class);
        Response response = ghostOrderAdminApi.getDetailGhostOrder(ghostOrderID);
        List<HashMap> lineItems = ghostOrderAdminApi.getLineItemToConvert(response, data);
        Map<String, Object> model = ghostOrderAdminApi.buildModelToConvert(lineItems, data.get(0).get("buyerID"), data.get(0).get("paymentType"), ghostOrderID);
        Map<String, Object> order = new HashMap<>();
        order.put("order", model);
        ghostOrderAdminApi.callConvertGhostOrder(order);
    }

    @And("Admin delete ghost order by api")
    public void delete_ghost_order_by_skuname() {
        List<String> idOrders = Serenity.sessionVariableCalled("List ID ghost Order API");
        for (String idOrder : idOrders) {
            Response response = ghostOrderAdminApi.callDeleteGhostOrder(idOrder);
            JsonPath jsonPath = response.jsonPath();
            String message = jsonPath.get("message");
            Ensure.that(message).equals("succeeded");
        }
    }

    @And("Admin save ghost order number by index {string}")
    public void admin_save_ghost_order_number_by_index(String index) {
        // save order Number
        String number = Serenity.sessionVariableCalled("Ghost Order Number API").toString();
        Serenity.setSessionVariable("Ghost Order Number API" + index).to(number);
        // save order ID
        String id = Serenity.sessionVariableCalled("Ghost Order ID API").toString();
        Serenity.setSessionVariable("Ghost Order ID API" + index).to(id);
    }
}
