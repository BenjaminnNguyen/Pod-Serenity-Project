package cucumber.tasks.api.admin.order;

import cucumber.models.api.admin.orders.CreateGhostOrder;
import cucumber.models.api.admin.orders.GhostLineItemsAttributes;
import cucumber.models.api.admin.orders.GhostOrderAttributes;
import cucumber.models.api.admin.orders.LineItemsAttributes;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GhostOrderAdminApi {

    CommonRequest commonRequest = new CommonRequest();
    OrdersAdminAPI ordersAdminAPI = new OrdersAdminAPI();

    /**
     * Handle Body Request
     */
    public Map<String, Object> buildModelToConvert(List<HashMap> lineItems, String buyerID, String paymentType, String ghostOrderID) {
        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("buyer_id", buyerID);
        order.putIfAbsent("ghost_order_id", ghostOrderID);
        order.putIfAbsent("payment_type", paymentType);
        order.putIfAbsent("line_items_attributes", lineItems);
        order.putIfAbsent("address_state_id", "36");
        order.putIfAbsent("address_state_code", "OH");
        order.putIfAbsent("address_state_name", "Ohio");
        order.putIfAbsent("street1", "12345 El Monte Road");
        order.putIfAbsent("zip", "43162");
        order.putIfAbsent("city", "West Jefferson");
        return order;
    }

    public CreateGhostOrder setCreateGhostOrderModel(DataTable dt) {
        List<Map<String, String>> orderAttribute = dt.asMaps(String.class, String.class);
        List<LineItemsAttributes> line_items_attributes = Serenity.sessionVariableCalled("List items order API");
        List<GhostLineItemsAttributes> ghost_line_items_attributes = Serenity.sessionVariableCalled("List ghost order line item API");
        String buyer_id = orderAttribute.get(0).get("buyer_id");
        String payment_type = orderAttribute.get(0).get("payment_type");
        String street1 = orderAttribute.get(0).get("street1");
        String city = orderAttribute.get(0).get("city");
        String address_state_id = orderAttribute.get(0).get("address_state_id");
        String zip = orderAttribute.get(0).get("zip");
        String number = orderAttribute.get(0).get("number");
        String street = orderAttribute.get(0).get("street");
        String customerPO = orderAttribute.get(0).get("customer_po");
        GhostOrderAttributes ghostOrderAttributes = new GhostOrderAttributes(line_items_attributes, ghost_line_items_attributes, buyer_id, payment_type, street1, city, address_state_id, zip, number, street, customerPO);
        CreateGhostOrder createGhostOrder = new CreateGhostOrder(ghostOrderAttributes);
        return createGhostOrder;
    }

    /**
     * Call request
     */
    public Response createGhostOrder(CreateGhostOrder order) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.CREATE_GHOST_ORDER, order, "POST");
//        System.out.println("RESPONSE CREATE GHOST ORDER:  " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE GHOST ORDER:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchGhostOrder(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_GHOST_ORDER, map, "GET");
//        System.out.println("RESPONSE SEARCH ORDERS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callConvertGhostOrder(Map<String, Object> convert) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.CREATE_ORDER, convert, "POST");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CONVERT GHOST ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteGhostOrder(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_GHOST_ORDER(idOrder), "DELETE");
//        System.out.println("RESPONSE DELETE GHOST ORDERS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE GHOST ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response getDetailGhostOrder(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_GHOST_ORDER(id), "GET");
        return response;
    }

    /**
     * Handle Response
     */

    public String getIdOrderCreated(Response response) {
        System.out.println(response.prettyPrint());
        JsonPath jsonPath = response.jsonPath();
        String idOrder = jsonPath.get("id").toString();
        String numberOrder = jsonPath.get("number").toString();
        List<String> lineItems = ordersAdminAPI.getLineItemsIdFromOrder(idOrder);
        Serenity.setSessionVariable("ID Order created by API").to(idOrder);
        List<String> listNumber;
        if (Serenity.hasASessionVariableCalled("List order's number created by API")) {
            listNumber = Serenity.sessionVariableCalled("List order's number created by API");
        } else {
            listNumber = new ArrayList<>();
        }
        listNumber.add(numberOrder);
        Serenity.setSessionVariable("List order's number created by API").to(listNumber);
        Serenity.setSessionVariable("List line items of order created by API").to(lineItems);
        return idOrder;
    }

    public String getIdGhostOrderCreated(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String idOrder = jsonPath.get("id").toString();
        return idOrder;
    }

    public String getNumberGhostOrderCreated(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String numberOrder = jsonPath.get("number").toString();
        System.out.println("Number ghost order " + numberOrder);
        return numberOrder;
    }

    public List<String> getListIdGhostOrder(Response response) {
        List<String> idOrders = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            idOrders.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("List ID ghost Order API").to(idOrders);
        System.out.println("ID ghost Order API: " + idOrders);
        return idOrders;
    }

    public List<HashMap> getLineItemToConvert(Response response, List<Map<String, String>> data) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> lineItems = jsonPath.get("line_items");
        List<HashMap> lineItems1 = new ArrayList<>();
        //
        for (HashMap item : lineItems) {
            for (Map<String, String> sku : data) {
                if (item.get("product_variant_id").toString().equals(sku.get("skuID"))) {
                    HashMap target = new HashMap<>();
                    target.putIfAbsent("product_variant_id", item.get("product_variant_id"));
                    target.putIfAbsent("quantity", item.get("quantity"));
                    target.putIfAbsent("variants_region_id", item.get("variants_region_id"));
                    target.putIfAbsent("fulfilled", false);
                    lineItems1.add(target);
                }
            }
        }
        return lineItems1;
    }
}
