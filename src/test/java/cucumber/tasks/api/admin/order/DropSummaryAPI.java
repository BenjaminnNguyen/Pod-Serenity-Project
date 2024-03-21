package cucumber.tasks.api.admin.order;

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

import javax.ws.rs.core.MediaType;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;

public class DropSummaryAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchSubInvoice(Map<String, Object> info) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_SUB_INVOICE_DROP, info, "GET");
        System.out.println("Search sub invoice " + response.prettyPrint());
        return response;
    }

    public Response callSearchDrop(Map<String, Object> info) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.CREATE_DROP, info, "GET");
        System.out.println("Search drop " + response.prettyPrint());
        return response;
    }

    public RequestSpecification setDropRequest(String url, List<Map<String, Object>> infos) {
        RestAssured.baseURI = url;
        RequestSpecification requestSpecification = new RequestSpecBuilder().build();
        for (Map<String, Object> info : infos) {
            String orderID = Serenity.sessionVariableCalled("ID Order API" + info.get("index"));
            String subInvoiceID = Serenity.sessionVariableCalled("Sub invoice of " + orderID + info.get("sub")).toString();

            requestSpecification
                    .formParam("drop[" + info.get("drop") + "][sub_invoices_attributes][" + info.get("subAtt") + "][id]", subInvoiceID)
                    .formParam("drop[" + info.get("drop") + "][sub_invoices_attributes][" + info.get("subAtt") + "][drop_small_order_surcharge_cents]", info.get("sos"))
                    .formParam("drop[" + info.get("drop") + "][sub_invoices_attributes][" + info.get("subAtt") + "][store_id]", info.get("store"))
                    .formParam("drop[" + info.get("drop") + "][sub_invoice_ids][add][]", subInvoiceID);
        }
        return requestSpecification;
    }

    public Map<String, Object> setCreateDropWithPO(List<Map<String, Object>> infos) {
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> drop = new HashMap<>();
        Map<String, Object> purchase_order_attributes = new HashMap<>();

        String orderID;
        Integer subInvoiceID;

        for (Map<String, Object> info : infos) {

            // Object purchase_order_attributes
            purchase_order_attributes.put("admin_note", info.get("adminNote"));
            purchase_order_attributes.put("logistics_partner_note", info.get("lpNote"));
            purchase_order_attributes.put("logistics_company_id", Integer.parseInt(info.get("lpCompanyID").toString()));

            // Object sub_invoices_attributes
            orderID = Serenity.sessionVariableCalled("ID Order API" + info.get("index")).toString();
            subInvoiceID = Serenity.sessionVariableCalled("Sub invoice of " + orderID + info.get("sub"));

            Map<String, Object> tempSubAtt = new HashMap<>();
            tempSubAtt.put("id", subInvoiceID);
            tempSubAtt.put("drop_small_order_surcharge_cents", Integer.parseInt(info.get("sos").toString()));
            tempSubAtt.put("store_id", info.get("store"));

            Map<String, Object> sub_invoices_attributes = new HashMap<>();
            sub_invoices_attributes.put(info.get("subAtt").toString(), tempSubAtt);


            // Object sub_invoice_ids
            List<Integer> idsSubInvoice = new ArrayList<>();
            idsSubInvoice.add(subInvoiceID);
            Map<String, Object> sub_invoice_ids = new HashMap<>();
            sub_invoice_ids.put("add", idsSubInvoice);

            Map<String, Object> tempDrop = new HashMap<>();
            tempDrop.put("create_with_po", true);
            tempDrop.put("purchase_order_attributes", purchase_order_attributes);
            tempDrop.put("sub_invoices_attributes", sub_invoices_attributes);
            tempDrop.put("sub_invoice_ids", sub_invoice_ids);

            drop.put(info.get("drop").toString(), tempDrop);
        }

        body.put("drop", drop);


        return body;
    }

    public Map<String, Object> setPoInDropRequest(List<Map<String, Object>> infos) {
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> drop = new HashMap<>();
        Map<String, Object> purchase_order_attributes = new HashMap<>();

        List<Integer> dropIDs = new ArrayList<>();
        for (Map<String, Object> info : infos) {
            String dropID = Serenity.sessionVariableCalled("Drop ID " + info.get("dropID")).toString();
            dropIDs.add(Integer.valueOf(dropID));
        }

        purchase_order_attributes.put("fulfillment_date", infos.get(0).get("fulfillmentDate"));
        purchase_order_attributes.put("fulfillment_state", infos.get(0).get("fulfillmentState"));
        purchase_order_attributes.put("admin_note", infos.get(0).get("adminNote"));
        purchase_order_attributes.put("logistics_partner_note", infos.get(0).get("lpNote"));
        purchase_order_attributes.put("logistics_company_id", infos.get(0).get("lpCompanyID"));

        drop.put("drop_ids", dropIDs);
        drop.put("purchase_order_attributes", purchase_order_attributes);

        body.put("drop", drop);
        return body;
    }

    public Response createDrop(String url, RequestSpecification requestSpec) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");
        RestAssured.baseURI = url;
        RequestSpecification requestSpecPO = Serenity.sessionVariableCalled("Create PO Drop API");
        // nếu có create po thì add thêm vào request
        if (requestSpecPO != null) {
            requestSpec.spec(requestSpecPO);
        }

        RequestSpecification requestHeader = new RequestSpecBuilder()
                .addHeader("token-type", "Bearer")
                .addHeader("access-token", accessToken)
                .addHeader("client", client)
                .addHeader("uid", uid)
                .build();

        Response response = given().log().all()
                .contentType(MediaType.MULTIPART_FORM_DATA.toString())
                .spec(requestHeader)
                // body
                .spec(requestSpec)
                .when()
                .config(RestAssured.config().encoderConfig(encoderConfig().encodeContentTypeAs("multipart/form-data", ContentType.TEXT)))
                .request("POST")
                .then().log().all()
                .extract()
                .response();
        return response;
    }

    public Response callcreateDropWithPO(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.CREATE_DROP, map, "POST");
        return response;
    }

    public Response callAssignPO(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ASSIGN_PO_DROP, map, "POST");
        return response;
    }

    public String getNumberDrop(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> result = jsonPath.get("results");
        String number = result.get(0).get("number").toString();
        return number;
    }

    public String getIDDrop(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> result = jsonPath.get("results");
        String id = result.get(0).get("id").toString();
        return id;
    }

}
