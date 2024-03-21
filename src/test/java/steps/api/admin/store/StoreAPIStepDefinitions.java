package steps.api.admin.store;

import cucumber.tasks.api.CommonHandle;
import io.cucumber.java.en.*;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.store.HandleStoreAdminAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StoreAPIStepDefinitions {

    CommonRequest commonRequest = new CommonRequest();

    HandleStoreAdminAPI storeAdminAPI = new HandleStoreAdminAPI();

    @And("Admin search store by API")
    public void search_store_by_api(DataTable dt) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(dt);
        Response response = storeAdminAPI.callSearchStore(info.get(0));
        storeAdminAPI.getIdStore(response);
    }

    @And("Admin delete store {string} by api")
    public void delete_store_by_skuname(String id) {
        List<String> idStores = Serenity.sessionVariableCalled("ID Store API");
        for (String idStore : idStores) {
            Response response = storeAdminAPI.callDeleteStoreByID(idStore);
            JsonPath jsonPath = response.jsonPath();
            String message = jsonPath.get("message");
            Ensure.that(message).equals("Store deleted");
        }
    }

    @And("Admin change status using SOS of store {string} to {string}")
    public void change_status_SOS_store_by_api(String id, String state) {
        boolean status = Boolean.parseBoolean(state);
        String basePath = UrlAdminAPI.STORE(id);
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("has_surcharge", status);
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
    }

    @And("Admin change info SOS of store {string}")
    public void change_SOS_of_store_by_api(String storeID, DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);

        Map<String, Object> map = storeAdminAPI.setInfoSOS(list.get(0));
        storeAdminAPI.callUpdateValueSOS(storeID, map);
    }

    @And("Admin change status using LS of store {string} to {string}")
    public void change_status_LS_store_by_api(String id, String state) {
        boolean status = Boolean.parseBoolean(state);
        String basePath = UrlAdminAPI.STORE(id);
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("has_logistics_surcharge", status);
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
    }

    @And("Admin change info of store {string} by api")
    public void admin_change_info_of_store_by_api(String storeID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        Map<String, Object> info = storeAdminAPI.setEditStoreModel(infos.get(0));
        Response response = storeAdminAPI.callEditStore(storeID, info);
    }

    @And("Admin change route of store by api")
    public void admin_change_route_of_store_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> routes_store_attributes = new HashMap<>();
        routes_store_attributes.putIfAbsent("id", "");
        routes_store_attributes.putIfAbsent("route_id", infos.get(0).get("routeID"));

        Map<String, Object> store = new HashMap<>();
        store.putIfAbsent("routes_store_attributes", routes_store_attributes);

        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(infos.get(0).get("storeID").toString()), store, "PUT");
    }

    @And("Admin remove route of store {string} by api")
    public void admin_remove_route_of_store_by_api(String storeID) {
        // get detail để lấy thông tin route
        Response response = storeAdminAPI.callGetDetailStore(storeID);
        // add thêm key destroy = true để remove
        HashMap route = storeAdminAPI.getInfoRoute(response);
        if (route != null) {
            route.putIfAbsent("_destroy", "true");
            //tạo body
            Map<String, Object> store = new HashMap<>();
            store.putIfAbsent("routes_store_attributes", route);
            // thực hiện remove route
            Response responseRemove = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(storeID), store, "PUT");
        }
    }

    @And("Admin set all possible delivery days of store {string} by api")
    public void admin_set_all_possible_delivery_days_of_store_by_api(String storeID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        // remove Set receiving weekday

        Response response1 = storeAdminAPI.callRemoveReceivingWeekday(storeID);
        Response response = storeAdminAPI.callSetAllPossibleDeliveryDays(storeID, infos);
    }

    @And("Admin set all receiving weekday of store {string} by api")
    public void admin_set_all_receiving_weekday_of_store_by_api(String storeID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        Response response = storeAdminAPI.callSetReceivingWeekday(storeID, infos);
    }

    @And("Admin create store by API")
    public void create_store_by_api(DataTable dt) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(dt);
        Map<String, Object> body = storeAdminAPI.setCreateStoreModel(info.get(0));
        Response response = storeAdminAPI.callCreateStore(body);
        storeAdminAPI.getIdStoreCreate(response);
    }

    @And("Admin update store {string} by API")
    public void setReceivingNote(String id, DataTable dt) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(dt);
        Map<String, Object> map = new HashMap<>();
        for (Map<String, Object> field : info) {
            map.putIfAbsent(field.get("field").toString(), field.get("value").toString());
            Response response = storeAdminAPI.callUpdateStore(id, map);
        }
    }

    @And("Admin change state of store {string} to {string}")
    public void call_edit_store(String storeID, String state) {
        if (storeID.contains("create by api"))
            storeID = Serenity.sessionVariableCalled("ID Store API");
        String curState = storeAdminAPI.getState(commonRequest.commonRequestNoBody(UrlAdminAPI.STORE(storeID), "GET"));
        if (!state.equals(curState)) {
            Response response = storeAdminAPI.callToggleStateStore(storeID);
        }
    }
}
