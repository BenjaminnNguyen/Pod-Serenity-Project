package cucumber.tasks.api.admin.order;

import cucumber.models.api.admin.orders.CreateOrder;
import cucumber.models.api.admin.orders.LineItemsAttributes;
import cucumber.models.api.admin.orders.OrderAttributes;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;

public class OrdersAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchOrderBySkuID(String skuName) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[product_variant_ids]", skuName);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_ORDER, map, "GET");
//        System.out.println("RESPONSE SEARCH ORDERS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteOrderByID(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_ORDER(idOrder), "DELETE");
//        System.out.println("RESPONSE DELETE ORDERS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchOrder(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_ORDER, map, "GET");
//        System.out.println("RESPONSE SEARCH ORDER " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH ORDER:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailOrder(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DETAIL_ORDER(idOrder), "GET");
//        System.out.println("RESPONSE DETAIL ORDER " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL ORDER:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteOrderBySkuName(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_ORDER(idOrder), "DELETE");
//        System.out.println("RESPONSE DELETE ORDERS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE ORDERS: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getIdOrder(Response response) {
        List<String> idOrders = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if (!item.get("payment_state").equals("paid") && !item.get("vendor_payment_state").equals("paid")) {
                idOrders.add(item.get("id").toString());
                System.out.println("ID Order API = " + item.get("id").toString());
            }
        }
        Serenity.setSessionVariable("ID Order API").to(idOrders);
        return idOrders;
    }

    public List<String> getIdPurchaseOrder(Response response) {
        List<String> idPOs = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("purchase_orders");
        if (results.size() > 0) {
            for (HashMap item : results) {
                idPOs.add(item.get("id").toString());
                System.out.println("ID Purchase Order API = " + item.get("id").toString());
            }
            Serenity.setSessionVariable("ID Purchase Order API").to(idPOs);
        }
        return idPOs;
    }

    public String getIdPurchaseOrder2(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String idPO = jsonPath.get("id").toString();
        String numberPO = jsonPath.get("number").toString();
        System.out.println("ID Purchase Order API = " + jsonPath.get("id").toString());
        System.out.println("Number Purchase Order API = " + jsonPath.get("number").toString());
        Serenity.setSessionVariable("ID Purchase Order API").to(idPO);
        Serenity.setSessionVariable("Number Purchase Order API").to(numberPO);
        return idPO;
    }

    public HashMap getProofOfPurchaseOrder(Response response, String idPO) {
        HashMap proof = new HashMap();
        List<HashMap> purchaseOrder = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        // lay ra 1 list purchase order
        purchaseOrder = jsonPath.get("purchase_orders");
        // tu list purchase order lay ra proof tuong ung vs ID purchase order
        for (HashMap item : purchaseOrder) {
            if (item.get("id").toString().equals(idPO)) {
                List<HashMap> temp = (List<HashMap>) item.get("proof_of_deliveries_attributes");
                if (temp.size() > 0) {
                    proof = temp.get(0);
                }
            }
        }
        Serenity.setSessionVariable("Proof info").to(proof);
        return proof;
    }

    public List<String> getLineItemsIdFromOrder(String orderId) {
        List<String> lineItemId = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("order_id", orderId);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.GET_LINE_ITEM_ORDER(orderId), map, "GET");
        System.out.println("RESPONSE LINE ITEM OF ORDER " + response.prettyPrint());
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> results = jsonPath.getList("line_items");
        for (Map<String, Object> i : results) {
            lineItemId.add(i.get("id").toString());
        }
        return lineItemId;
    }

    public Response callLineItemOfOrder(String orderId) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("order_id", orderId);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.GET_LINE_ITEM_ORDER(orderId), map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE LINE ITEM OF ORDER : ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteLineItemOfOrder(String orderId, HashMap body) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.DELETE_ORDER(orderId), body, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE LINE ITEM OF ORDER : ").andContents(response.prettyPrint());
        return response;
    }

    public String getLineItemIdOfSKUFromOrder(Response response, String skuName, String skuID) {
        String lineItemId = null;
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> results = jsonPath.getList("line_items");
        for (Map<String, Object> i : results) {
            if (i.get("product_variant_name").toString().contains(skuName) || i.get("product_variant_id").toString().equals(skuID)) {
                lineItemId = i.get("id").toString();
                break;
            }
        }
        return lineItemId;
    }

    public List<HashMap> getLineItemsOfOrder(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> lineItem = jsonPath.get("line_items");
        return lineItem;
    }

    public Response fulfilledLineItemsIdFromOrder(String orderId, List<String> itemId, Boolean status) {
        Map<String, Object> order = new HashMap<>();
        Map<String, Object> line_items = new HashMap<>();
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        for (String i : itemId) {
            Map<String, Object> item_attributes = new HashMap<>();
            item_attributes.putIfAbsent("id", Integer.parseInt(i));
            item_attributes.putIfAbsent("fulfilled", status);
            line_items_attributes.add(item_attributes);
        }
        line_items.putIfAbsent("line_items_attributes", line_items_attributes);
        order.putIfAbsent("order", line_items);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId), order, "PUT");
        System.out.println("RESPONSE FULFILL OR UN FULFILL LINE ITEM " + response.prettyPrint());
        return response;
    }

    public Response updateFulfilledLineItemsIdFromOrder(Integer orderId, Integer itemId, Boolean fulfill) {
        Map<String, Object> order = new HashMap<>();
        Map<String, Object> line_items = new HashMap<>();
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        Map<String, Object> item_attributes = new HashMap<>();
        item_attributes.putIfAbsent("id", itemId);
        item_attributes.putIfAbsent("fulfilled", fulfill);
        line_items_attributes.add(item_attributes);
        line_items.putIfAbsent("line_items_attributes", line_items_attributes);
        order.putIfAbsent("order", line_items);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId.toString()), order, "PUT");
        return response;
    }

    public Response fulfilledLineItemsIdFromOrder(String orderId, Map<String, Object> info) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId), info, "PUT");
        System.out.println("RESPONSE FULFILL OR UN FULFILL LINE ITEM " + response.prettyPrint());
        return response;
    }

    public Map<String, Object> setOrderObject(List<HashMap<String, Object>> map) {
        Map<String, Object> order = new HashMap<>();
        Map<String, Object> line_items = new HashMap<>();
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        for (HashMap<String, Object> item : map) {
            Map<String, Object> item_attributes = new HashMap<>();
            item_attributes.putIfAbsent("id", item.get("id"));
            item_attributes.putIfAbsent("fulfilled", item.get("state"));
            // thêm ngày fulfill nếu cần thiết
            if (item.containsKey("fulfillmentDate")) {
                item_attributes.putIfAbsent("fulfillment_date", item.get("fulfillmentDate"));
            }
            line_items_attributes.add(item_attributes);
        }
        line_items.putIfAbsent("line_items_attributes", line_items_attributes);
        order.putIfAbsent("order", line_items);
        return order;
    }

    public Response updateQuantity(String orderId, Integer lineId, Integer quantity) {
        Map<String, Object> order = new HashMap<>();
        Map<String, Object> order2 = new HashMap<>();
        Map<String, Object> line_items = new HashMap<>();
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        line_items.putIfAbsent("id", lineId);
        line_items.putIfAbsent("quantity", quantity);
        line_items_attributes.add(line_items);
        order.putIfAbsent("line_items_attributes", line_items_attributes);
        order2.putIfAbsent("order", order);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId), order2, "PUT");
        return response;
    }

    // change purchase order(ko co proof) thanh unconfirmed
    public Response callChangePO(String idPO) {
        Map<String, Object> purchase_order = new HashMap<>();
        Map<String, Object> item = new HashMap<>();

        item.putIfAbsent("fulfillment_state", "unconfirmed");
        item.putIfAbsent("fulfillment_date", "");
        purchase_order.putIfAbsent("purchase_order", item);

        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.PURCHASE_ORDER(idPO), purchase_order, "PUT");
        System.out.println("RESPONSE UNCONFIRMED PO " + response.prettyPrint());
        return response;
    }

    // change purchase order(co proof) thanh unconfirmed
    public Response callChangePOwithProofToUnconfirm(String idPO, HashMap proof) {
        // send request dang form data
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");
        RestAssured.baseURI = UrlAdminAPI.PURCHASE_ORDER(idPO);
        Response response = given()
                .contentType("multipart/form-data")
                .headers("token-type", "Bearer")
                .headers("access-token", accessToken)
                .headers("client", client)
                .headers("uid", uid)
                // body
                .formParam("purchase_order[fulfillment_date]", "")
                .formParam("purchase_order[fulfillment_state]", "unconfirmed")
                .formParam("purchase_order[admin_note]", "")
                .formParam("purchase_order[logistics_partner_note]", "")
                .formParam("purchase_order[proof_of_deliveries_attributes][0][id]", proof.get("id"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][file_name]", proof.get("file_name"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][link]", proof.get("link"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][uploader_type]", proof.get("uploader_type"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][uploader_name]", proof.get("uploader_name"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][uploaded_time]", proof.get("uploaded_time"))
                .formParam("purchase_order[proof_of_deliveries_attributes][0][_destroy]", true)
                .when()
                .config(RestAssured.config().encoderConfig(encoderConfig().encodeContentTypeAs("multipart/form-data", ContentType.TEXT)))
                .request("PUT")
                .then()
                .extract()
                .response();
        System.out.println("RESPONSE UNCONFIRMED PO " + response.prettyPrint());
        return response;
    }

    public Response callDeletePO(String idPO) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.PURCHASE_ORDER(idPO), "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PO ORDER:  ").andContents(response.prettyPrint());
//        System.out.println("RESPONSE DELETE PO " + response.prettyPrint());
        return response;
    }

    public Response callCreateOrder(CreateOrder createOrder) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.CREATE_ORDER, createOrder, "POST");
        System.out.println("CREATE ORDER " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE ORDER:  ").andContents(response.prettyPrint());
        return response;
    }

    public CreateOrder setCreateOrderModel(Map<String, String> map) {
        List<LineItemsAttributes> line_items_attributes = Serenity.sessionVariableCalled("List items order API");
        String buyer_id = map.get("buyer_id");
        if (buyer_id.contains("create by api"))
            buyer_id = Serenity.sessionVariableCalled("Buyer Account ID");
        OrderAttributes orderAttributes = new OrderAttributes(line_items_attributes, buyer_id, map.get("customer_po"), map.get("admin_note"), map.get("payment_type"), map.get("num_of_delay"), map.get("attn"),
                map.get("street1"), map.get("city"), map.get("address_state_id"), map.get("zip"), Boolean.parseBoolean(map.get("has_surcharge")), map.get("department"),
                map.get("address_state_code"), map.get("address_state_name"));
        return new CreateOrder(orderAttributes);
    }

    /**
     * Hàm get id của order
     *
     * @param response response trả về khi create order
     * @return
     */

    public String getNumberOrderCreated(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String idOrder = jsonPath.get("number");
        System.out.println("Number Order = " + idOrder);
        Serenity.setSessionVariable("Number Order API").to(idOrder);
        Serenity.setSessionVariable("ID Order").to(idOrder);
        Serenity.setSessionVariable("ID Invoice").to(idOrder);
        return idOrder;
    }

    /**
     * Hàm get id của order sau khi create
     *
     * @param response response trả về khi create order
     * @return
     */

    public String getIdOrderCreated(Response response) {
        JsonPath jsonPath = response.jsonPath();
        int idOrder = jsonPath.get("id");
        System.out.println("ID Order API = " + idOrder);
        Serenity.setSessionVariable("ID Order API").to(idOrder);
        Serenity.setSessionVariable("order_id").to(idOrder);
        return String.valueOf(idOrder);
    }

    public Response callCreateSubInvoice(Map<String, Object> sub_invoice) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.CREATE_SUB_INVOICE, sub_invoice, "POST");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SUBINVOICE:  ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Get sub invoice id từ response
     *
     * @param response
     * @return
     */
    public String getSubInvoiceId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String subInvoice = jsonPath.get("number");
        System.out.println("Sub-invoice ID create by admin = " + subInvoice);
        Serenity.setSessionVariable("Sub-invoice ID create by admin").to(subInvoice);
        return subInvoice;
    }

    public void getSubInvoice(Response response, String order, Map<String, String> info) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> listID = new ArrayList<>();
        List<HashMap> sub_invoices = jsonPath.get("sub_invoices");
        for (HashMap item : sub_invoices) {
            if (item.get("surfix").equals(info.get("subInvoice").toString())) {
                System.out.println("Sub invoice of " + order + info.get("subInvoice") + " = " + item.get("id"));
                Serenity.setSessionVariable("Sub invoice of " + order + info.get("subInvoice")).to(item.get("id"));
            }
        }
    }

    /**
     * Set delivery not set cho line item in order
     *
     * @param orderId
     * @return
     */
    public Response setDeliveryNotSetInLineItem(String orderId, List<String> idsLineItem) {
        Map<String, Object> order = new HashMap<>();
        Map<String, Object> line_items = new HashMap<>();
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        for (String i : idsLineItem) {
            Map<String, Object> item_attributes = new HashMap<>();
            item_attributes.putIfAbsent("id", Integer.parseInt(i));
            item_attributes.putIfAbsent("warehouse_id", "");
            line_items_attributes.add(item_attributes);
        }
        line_items.putIfAbsent("line_items_attributes", line_items_attributes);
        order.putIfAbsent("order", line_items);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId), order, "PUT");
        System.out.println("RESPONSE SET DELIVERABLE NOT SET " + response.prettyPrint());
        return response;
    }


    public Response callEditGeneralDetailOrder(String orderID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.DETAIL_ORDER(orderID), map, "PUT");
        System.out.println("RESPONSE EDIT GENERAL DETAIL ORDER " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT GENERAL DETAIL ORDER:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditDisplaySurcharge(String lineItemID, Boolean status) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("display_surcharge", status);
        Map<String, Object> subInvoice = new HashMap<>();
        subInvoice.putIfAbsent("sub_invoice", map);

        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.SUB_INVOICE(lineItemID), subInvoice, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT DISPLAY SURCHARGE: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getSubInvoiceIdFromOrderDetail(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> idSubs = new ArrayList<>();
        List<String> numSubs = new ArrayList<>();
        List<HashMap> subInvoices = jsonPath.get("sub_invoices");
        for (HashMap subInvoice : subInvoices) {
            idSubs.add(subInvoice.get("id").toString());
            numSubs.add(subInvoice.get("number").toString());
        }
        System.out.println("Sub-invoice ID create by admin = " + idSubs);
        Serenity.setSessionVariable("Sub-invoice ID").to(idSubs);
        Serenity.setSessionVariable("Sub-invoice numbers api").to(numSubs);
        return idSubs;
    }

    public String getPOIdFromOrderDetail(Response response, String subInvoiceId) {
        JsonPath jsonPath = response.jsonPath();
        String id = "";
        List<HashMap> purchase_orders = jsonPath.get("purchase_orders");
        for (HashMap purchase_order : purchase_orders) {
            if (purchase_order.get("sub_invoice_id").toString().equals(subInvoiceId)) {
                id = purchase_order.get("id").toString();
            }
        }
        return id;
    }

    public Response callCreatePO(String subInvoiceID, Map<String, Object> map) {
        Map<String, Object> param = new HashMap<>();
        param.put("purchase_order[sub_invoice_id]", subInvoiceID);
        param.put("purchase_order[fulfillment_date]", CommonHandle.setDate2(map.get("fulfillment_date").toString(), "yyyy-MM-dd"));
        param.put("purchase_order[fulfillment_state]", map.get("fulfillment_state"));
        param.put("purchase_order[admin_note]", map.get("admin_note"));
        param.put("purchase_order[logistics_partner_note]", map.get("logistics_partner_note"));
        param.put("purchase_order[proof_of_deliveries_attributes][]", map.get("proof_of_deliveries_attributes"));
        param.put("purchase_order[logistics_company_id]", map.get("logistics_company_id"));
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.PURCHASE_ORDER, param, "POST");
        return response;
    }

    public Response updatePO(String poId, String subInvoiceID, Map<String, Object> map) {
        Map<String, Object> param = new HashMap<>();
        param.put("purchase_order[id]", poId);
        param.put("purchase_order[sub_invoice_id]", subInvoiceID);
        param.put("purchase_order[fulfillment_date]", CommonHandle.setDate2(map.get("fulfillment_date").toString(), "yyyy-MM-dd"));
        param.put("purchase_order[fulfillment_state]", map.get("fulfillment_state"));
        param.put("purchase_order[admin_note]", map.get("admin_note"));
        param.put("purchase_order[logistics_partner_note]", map.get("logistics_partner_note"));
        param.put("purchase_order[proof_of_deliveries_attributes][]", map.get("proof_of_deliveries_attributes"));
        param.put("purchase_order[logistics_company_id]", map.get("logistics_company_id"));
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.PURCHASE_ORDER(poId), param, "PUT");
        return response;
    }

    public RequestSpecification callCreatePO1(String url, String poId, Map<String, Object> map) {
        RestAssured.baseURI = url;
        RequestSpecification requestSpecification = new RequestSpecBuilder().build();

        requestSpecification
                .formParam("purchase_order[sub_invoice_id]", poId)
                .formParam("purchase_order[fulfillment_date]", CommonHandle.setDate2(map.get("fulfillment_date").toString(), "yyyy-MM-dd"))
                .formParam("purchase_order[fulfillment_state]", map.get("fulfillment_state"))
                .formParam("purchase_order[admin_note]", map.get("admin_note"))
                .formParam("purchase_order[logistics_partner_note]", map.get("logistics_partner_note"))
                .formParam("purchase_order[proof_of_deliveries_attributes][]", map.get("proof_of_deliveries_attributes"))
                .formParam("purchase_order[logistics_company_id]", map.get("logistics_company_id"));
        if (map.containsKey("pod")) {
            requestSpecification
                    .multiPart("purchase_order[proof_of_deliveries_attributes][0][attachment]", new File(System.getProperty("user.dir") + "/src/test/resources/Images/" + map.get("pod")));
        }

        return requestSpecification;
    }

    /**
     * Set line item to delete
     *
     * @param orderId
     * @return
     */
    public HashMap setLineItemToDelete(List<HashMap> mapList, List<Map<String, Object>> infos) {
        HashMap body = new HashMap();
        Map<String, Object> line_items_attributes = new HashMap();
        for (HashMap item : mapList) {
            for (Map<String, Object> item1 : infos) {
                if (item.get("product_variant_name").equals(item1.get("sku")) && item.get("product_variant_id").toString().equals(item1.get("skuID"))) {
                    item.putIfAbsent("reason", item1.get("reason"));
                    item.putIfAbsent("_destroy", true);
                }
            }
        }
        line_items_attributes.putIfAbsent("line_items_attributes", mapList);
        body.putIfAbsent("order", line_items_attributes);
        return body;
    }


}
