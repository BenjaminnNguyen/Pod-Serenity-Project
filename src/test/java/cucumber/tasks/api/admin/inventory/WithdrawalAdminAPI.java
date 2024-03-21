package cucumber.tasks.api.admin.inventory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class WithdrawalAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchWithdrawal(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_WITHDRAWAL, map, "GET");
        System.out.println("RESPONSE SEARCH WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callApproveWithdrawal(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_APPROVE_WITHDRAWAL(id), "PUT");
        System.out.println("RESPONSE APPROVE WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE APPROVE WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCompleteWithdrawal(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_COMPLETE_WITHDRAWAL(id), "PUT");
        System.out.println("RESPONSE ADMIN_COMPLETE_WITHDRAWAL WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ADMIN_COMPLETE_WITHDRAWAL WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateWithdrawal(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_WITHDRAWAL, map, "POST");
        System.out.println("RESPONSE CREATE WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public String callCreateWithdrawal(RequestBody body) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client1 = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");
        OkHttpClient client = new OkHttpClient().newBuilder()
                .connectTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("text/plain");

        Request request = new Request.Builder()
                .url(UrlAdminAPI.ADMIN_GET_WITHDRAWAL)
                .method("POST", body)
                .addHeader("uid", uid)
                .addHeader("access-token", accessToken)
                .addHeader("client", client1)
                .addHeader("token-type", "Bearer")
                .build();
        okhttp3.Response response = null;
        // in ra report response
        try {
            ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
            response = client.newCall(request).execute();
            String responseString = response.body().string();
            System.out.println("RESPONSE CREATE WITHDRAWAL " + responseString);
//            Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE WITHDRAWAL:  ").andContents(responseString);
            return responseString;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    public Response callDetailWithdrawal(String idWithdrawal) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_GET_DETAIL_WITHDRAWAL(idWithdrawal), "GET");
        System.out.println("RESPONSE DETAIL WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteWithdrawal(String idWithdrawal) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_DELETE_WITHDRAWAL(idWithdrawal), "DELETE");
        System.out.println("RESPONSE DELETE WITHDRAWAL " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE WITHDRAWAL:  ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getListIdWithdrawal(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> listID = new ArrayList<>();
        List<HashMap> inventoryItems = jsonPath.get("results");
        for (HashMap item : inventoryItems) {
            listID.add(item.get("id").toString());
        }
        return listID;
    }

    public String getIdWithdrawal(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        String number = jsonPath.get("number").toString();
        Serenity.setSessionVariable("Id Withdraw request api").to(id);
        Serenity.setSessionVariable("Number Withdraw request api").to(number);
        return id;
    }

    public String getIdWithdrawal2(String response, String index) {
        JSONObject jsonObject = new JSONObject(response);
        String id = jsonObject.get("id").toString();
        String number = jsonObject.get("number").toString();
        JSONArray jsonObject2 = jsonObject.getJSONArray("withdraw_items_attributes");
        for (int i = 0; i < jsonObject2.length(); i++) {
            String lot = jsonObject2.getJSONObject(i).get("inventory_lot_code").toString();
            Serenity.setSessionVariable("Number Withdraw request api" + lot).to(number);
        }
        if (index != "") {
            Serenity.setSessionVariable("Number Withdraw request api" + index).to(number);
        }
        Serenity.setSessionVariable("Id Withdraw request api").to(id);
        Serenity.setSessionVariable("Number Withdraw request api").to(number);
        return id;
    }

    public String getStatusWithdrawal(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String status = jsonPath.get("status");
        return status;
    }

    public List<String> getListIdLotcodeOfInWithdrawalDetail(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> listIdLotCode = new ArrayList<>();
        List<HashMap> inventoryItems = jsonPath.get("withdraw_items_attributes");
        for (HashMap item : inventoryItems) {
            listIdLotCode.add(item.get("id").toString());
        }
        return listIdLotCode;
    }

    public Boolean checkSkuInWithdrawDetail(Response response, String sku) {
        Boolean check = false;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> inventoryItems = jsonPath.get("withdraw_items_attributes");
        String status = jsonPath.get("status");
        if (!status.equals("completed")) {
            for (HashMap item : inventoryItems) {
                if (item.get("product_variant_name").toString().contains(sku)) {
                    check = true;
                    break;
                }
            }
        }
        return check;
    }

    public void verifyDeleteSuccess(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String message = jsonPath.get("message");
        Ensure.that(message).equals("Withdraw form deleted");
    }


}
