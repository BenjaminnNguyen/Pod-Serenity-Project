package cucumber.tasks.api.admin.store;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleStoreAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchStore(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_STORE, map, "GET");
//        System.out.println("RESPONSE SEARCH STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetDetailStore(String storeID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE(storeID), "GET");
        System.out.println("RESPONSE GET DETAIL STORE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET DETAIL STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateStore(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.SEARCH_STORE, map, "POST");
        System.out.println("RESPONSE CREATE STORE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callUpdateStore(String storeID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.STORE(storeID), map, "PUT");
        System.out.println("RESPONSE UPDATE STORE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Get ID store after search
     *
     * @param response
     * @return
     */
    public List<String> getIdStore(Response response) {
        List<String> idStores = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            idStores.add(item.get("id").toString());
        }
        System.out.println("id = " + idStores);
        Serenity.setSessionVariable("ID Store API").to(idStores);
        return idStores;
    }

    /**
     * Get ID store after create
     *
     * @param response
     * @return
     */
    public String getIdStoreCreate(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String storeID = jsonPath.get("id").toString();
        System.out.println("Store ID = " + storeID);
        Serenity.setSessionVariable("ID Store API").to(storeID);
        return storeID;
    }

    public HashMap getInfoRoute(Response response) {
        JsonPath jsonPath = response.jsonPath();
        HashMap routes = jsonPath.get("routes_store");
        Serenity.setSessionVariable("Route Store").to(routes);
        return routes;
    }

    public Response callDeleteStoreByID(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE(idOrder), "DELETE");
//        System.out.println("RESPONSE DELETE STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE STORE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callUpdateSOS(String idOrder) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE(idOrder), "DELETE");
//        System.out.println("RESPONSE DELETE STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE STORE: ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setInfoSOS(Map<String, Object> info) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("amount_cents", info.get("amount_cents"));
        map.putIfAbsent("flat_fee_cents", info.get("flat_fee_cents"));

        Map<String, Object> small_order_surcharge_attributes = new HashMap<>();
        small_order_surcharge_attributes.putIfAbsent("small_order_surcharge_attributes", map);

        Map<String, Object> store = new HashMap<>();
        store.putIfAbsent("store", small_order_surcharge_attributes);
        return store;
    }

    public Response callUpdateValueSOS(String storeID, Map<String, Object> info) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(storeID), info, "PUT");
//        System.out.println("RESPONSE UPDATE INFO SOS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE INFO SOS: ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setEditStoreModel(Map<String, Object> info) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("attn", info.get("attn"));
        map.putIfAbsent("full_name", info.get("full_name"));
        map.putIfAbsent("street1", info.get("street1"));
        if (info.containsKey("street2")) {
            map.putIfAbsent("street2", info.get("street2"));
        }
        map.putIfAbsent("city", info.get("city"));
        map.putIfAbsent("address_state_id", info.get("address_state_id"));
        map.putIfAbsent("zip", info.get("zip"));
        map.putIfAbsent("id", info.get("id"));
        map.putIfAbsent("address_state_code", info.get("address_state_code"));
        map.putIfAbsent("address_state_name", info.get("address_state_name"));

        Map<String, Object> attribute = new HashMap<>();
        attribute.putIfAbsent("address_attributes", map);
        if (info.containsKey("phone_number")) {
            attribute.putIfAbsent("phone_number", info.get("phone_number"));
        }
        // Nếu edit Express receiving note
        if (info.containsKey("receiving_note")) {
            attribute.putIfAbsent("receiving_note", info.get("receiving_note"));
        }
        // Nếu edit Direct receiving note
        if (info.containsKey("direct_receiving_note")) {
            attribute.putIfAbsent("direct_receiving_note", info.get("direct_receiving_note"));
        }
        Map<String, Object> store = new HashMap<>();
        store.putIfAbsent("store", attribute);
        return store;
    }

    public Response callEditStore(String storeID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(storeID), map, "PUT");
//        System.out.println("RESPONSE EDIT STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSetAllPossibleDeliveryDays(String idOrder, List<Map<String, Object>> infos) {
        List<String> item = new ArrayList<>();
        // set list ngày update
        for (Map<String, Object> info : infos) {
            item.add((String) info.get("day"));
        }
        // tạo body
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("preferred_delivery_week_day", item);
//        Map<String, Object> store = new HashMap<>();
//        store.putIfAbsent("store", map);

        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(idOrder), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT ALL POSSIBLE DELIVERY DAYS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callRemoveReceivingWeekday(String idOrder) {
        List<HashMap> receiving_week_day = new ArrayList<>();
        // tạo body
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("receiving_week_day", receiving_week_day);

        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(idOrder), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE REMOVE POSSIBLE DELIVERY DAYS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSetReceivingWeekday(String idOrder, List<Map<String, Object>> infos) {
        List<String> item = new ArrayList<>();
        // set list ngày update
        for (Map<String, Object> info : infos) {
            item.add((String) info.get("day"));
        }
        // tạo body
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("receiving_week_day", item);
        Map<String, Object> store = new HashMap<>();
        store.putIfAbsent("store", map);

        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.STORE(idOrder), store, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT ALL POSSIBLE DELIVERY DAYS: ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setCreateStoreModel(Map<String, Object> info) {
        HashMap<String, Object> body = new HashMap<>(info);
        // model address
        Map<String, Object> address = new HashMap<>();
        address.putIfAbsent("city", info.get("city"));
        address.putIfAbsent("street1", info.get("street1"));
        address.putIfAbsent("street2", "");
        address.putIfAbsent("address_state_id", info.get("address_state_id"));
        address.putIfAbsent("zip", info.get("zip"));
        address.putIfAbsent("phone_number", info.get("phone_number"));
        address.putIfAbsent("number", info.get("number"));
        address.putIfAbsent("street", info.get("street"));

        // model logo
        Map<String, Object> logo = new HashMap<>();
        logo.putIfAbsent("attachment", "");

        // model store chinh
        HashMap<String, Object> store = new HashMap<>();
        store.putIfAbsent("name", info.get("name"));
        store.putIfAbsent("email", info.get("email"));
        store.putIfAbsent("ap_email", "");
        store.putIfAbsent("region_id", info.get("region_id"));
        store.putIfAbsent("time_zone", info.get("time_zone"));
        store.putIfAbsent("store_size", info.get("store_size"));
        store.putIfAbsent("store_type_id", info.get("store_type_id"));
        // nếu buyer company tạo bằng api
        if (info.get("buyer_company_id").equals("create by api")) {
            store.putIfAbsent("buyer_company_id", Serenity.sessionVariableCalled("Buyer Company ID"));
        } else {
            store.putIfAbsent("buyer_company_id", info.get("buyer_company_id"));
        }
        store.putIfAbsent("manager_id", "");
        store.putIfAbsent("launcher_id", "");
        store.putIfAbsent("referral_vendor_company_id", "");
        store.putIfAbsent("phone_number", info.get("phone_number"));
        store.putIfAbsent("referral_vendor_company_id", new ArrayList<>());
        store.putIfAbsent("receiving_week_day", new ArrayList<>());
        store.putIfAbsent("prefered_within_7_business_day", false);
        store.putIfAbsent("receiving_earliest_time", "");
        store.putIfAbsent("receiving_latest_time", "");
        store.putIfAbsent("receiving_note", "");
        store.putIfAbsent("dropship", false);
        store.putIfAbsent("has_surcharge", true);
        store.putIfAbsent("use_default_surcharge", true);
        store.putIfAbsent("has_logistics_surcharge", true);
        store.putIfAbsent("delivery_with_liftgate", false);
        store.putIfAbsent("auto_receive_invoice", true);
        store.putIfAbsent("address_attributes", address);
        store.putIfAbsent("small_order_surcharge_attributes", "");
        store.putIfAbsent("logo_attributes", logo);
        store.putIfAbsent("stores_tags_attributes", new ArrayList<>());

        return store;
    }

    public Response callToggleStateStore(String storeID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE_TOGGLE_STATE(storeID), "PUT");
//        System.out.println("RESPONSE TOGGLE STATE STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE TOGGLE STATE STORE:  ").andContents(response.prettyPrint());
        return response;
    }

    public String getState(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String state = jsonPath.get("state").toString();
        System.out.println("State of store = " + state);
        Serenity.setSessionVariable("State of Store").to(state);
        return state;
    }
}
