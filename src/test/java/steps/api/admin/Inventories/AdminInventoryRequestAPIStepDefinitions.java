package steps.api.admin.Inventories;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.inventory.InventoryRequestAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminInventoryRequestAPIStepDefinitions {

    @And("Admin search dispose donate request by API")
    public void search_dispose_donate_request_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);

        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        Response response = inventoryRequestAPI.callSearchInventoryRequest(infoObj.get(0));

        List<String> ids = inventoryRequestAPI.getIDsRequest(response);
        System.out.println("Inventory Request IDs " + ids);
        Serenity.setSessionVariable("Inventory Request IDs").to(ids);
    }


    @And("Admin delete all inventory request by API")
    public void admin_delete_inventory_request_by_api() {
        List<String> ids = Serenity.sessionVariableCalled("Inventory Request IDs");
        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        if (ids.size() > 0) {
            for (String id : ids) {
                inventoryRequestAPI.callDeleteInventoryRequest(id);
            }
        }
    }


    @And("Admin cancel all inventory request by API")
    public void admin_cancel_inventory_request_by_api() {
        Map<String, Object> map = new HashMap<>();
        map.put("reason", "auto");
        Map<String, Object> map2 = new HashMap<>();
        map2.put("inventory_request", map);
        List<String> ids = Serenity.sessionVariableCalled("Inventory Request IDs");
        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        if (ids.size() > 0) {
            for (String id : ids) {
                inventoryRequestAPI.callCancelInventoryRequest(id, map2);
            }
        }
    }

    @And("Admin set inventory request items API")
    public void admin_set_inventory_request_by_api(DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        List<Map<String, Object>> mapArrayList = new ArrayList<>();

        for (Map<String, Object> map : list) {
            Map<String, Object> a = new HashMap<>();
            String inventory_id = map.get("inventory_id").toString();
            String product_variant_id = map.get("product_variant_id").toString();
            if (map.get("inventory_id").equals("create by api")) {
                // nếu có 1 inventory của sku
                inventory_id = Serenity.sessionVariableCalled("Id Inventory api").toString();
                // nếu muốn chọn 1 trong nhiều inventory của sku
                if (map.containsKey("index")) {
                    inventory_id = Serenity.sessionVariableCalled("Inventory ID" + map.get("sku") + map.get("index")).toString();
                }
            }
            if (map.get("product_variant_id").equals("create by api")) {
                product_variant_id = Serenity.sessionVariableCalled("itemCode" + map.get("sku")).toString();
            }
            a.put("inventory_id", inventory_id);
            a.put("product_variant_id", product_variant_id);
            a.put("request_case", map.get("request_case"));
            mapArrayList.add(a);
        }

        Serenity.setSessionVariable("inventory_request_items_attributes").to(mapArrayList);
    }

    @And("Admin create dispose donate request by API")
    public void create_dispose_donate_request_by_api(DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        List<Map<String, Object>> infoObj = Serenity.sessionVariableCalled("inventory_request_items_attributes");
        Map<String, Object> a = new HashMap<>();
        Map<String, Object> inventory_request = new HashMap<>();
        a.put("comment", list.get(0).get("comment"));
        a.put("region_id", list.get(0).get("region_id"));
        a.put("request_type", list.get(0).get("request_type"));
        a.put("vendor_company_id", list.get(0).get("vendor_company_id"));
        a.put("inventory_request_items_attributes", infoObj);
        inventory_request.put("inventory_request", a);
        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        Response response = inventoryRequestAPI.callCreateInventoryRequest(inventory_request);
        String id = inventoryRequestAPI.getIDRequest(response);

    }

    @And("Admin approved dispose donate request by API")
    public void approved_dispose_donate_request_by_api() {
        String id = Serenity.sessionVariableCalled("Inventory Request ID API");
        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        Response response = inventoryRequestAPI.callApprovedInventoryRequest(id);
    }

    @And("Admin completed dispose donate request by API")
    public void completed_dispose_donate_request_by_api() {
        String id = Serenity.sessionVariableCalled("Inventory Request ID API");
        InventoryRequestAPI inventoryRequestAPI = new InventoryRequestAPI();
        Response response = inventoryRequestAPI.callCompletedInventoryRequest(id);
    }

}
