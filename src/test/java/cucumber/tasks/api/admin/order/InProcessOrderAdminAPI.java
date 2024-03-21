package cucumber.tasks.api.admin.order;

import cucumber.models.api.admin.orders.CreateOrder;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InProcessOrderAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callCreateInProcessOrder(CreateOrder createOrder) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.CREATE_IN_PROCESS_ORDER, createOrder, "POST");
        System.out.println("RESPONSE = " + response.prettyPrint());
        return response;
    }

    public Response callSearchInProcessOrder(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_IN_PROCESS_ORDER, map, "GET");
        return response;
    }

    public Response callDetailInProcessOrder(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DETAIL_IN_PROCESS_ORDER(id), "GET");
        return response;
    }

    /**
     * Hàm get id của order in process sau khi create
     *
     * @param response response trả về khi create order in process
     * @return
     */

    public String getIdOrderCreated(Response response) {
        JsonPath jsonPath = response.jsonPath();
        int idOrder = jsonPath.get("id");
        System.out.println("ID Order In Process API = " + idOrder);
        Serenity.setSessionVariable("ID Order In Process API").to(idOrder);
        Serenity.setSessionVariable("order_id").to(idOrder);
        return String.valueOf(idOrder);
    }

    public String getNumberOrder(Response response, String id) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        String numberOrder = null;
        for (HashMap item : results) {
            if (item.get("id").equals(id)) {
                numberOrder = item.get("order_number").toString();
                System.out.println("Number Order In Process API = " + numberOrder);
                Serenity.setSessionVariable("Number Order API").to(numberOrder);
                break;
            }
        }

        return numberOrder;
    }

    /**
     * Hàm get id của order từ detail
     *
     * @param response response trả về khi create order in process
     * @return
     */

    public String getNumberOrderFromDetail(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String idOrder = null;
        if(jsonPath.get("order_id") == null) {
            idOrder = null;
        } else {
            idOrder = jsonPath.get("order_id").toString();
        }
        System.out.println("Number Order In Process API = " + idOrder);
        Serenity.setSessionVariable("Number Order API").to(idOrder);

        return idOrder;
    }
}
