package cucumber.tasks.api.admin.inventory;

import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.models.api.InventoriesActivities;
import cucumber.models.api.InventoriesItems;
import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InventoryAPI {

    CommonRequest commonRequest = new CommonRequest();

    public List<String> getIdInventory(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> stringList = new ArrayList<>();
        List<HashMap> inventory = jsonPath.get("results");

        for (int i = 0; i < inventory.size(); i++) {
            String id = inventory.get(i).get("id").toString();
            stringList.add(id);
        }
        return stringList;
    }

    public Response getInfoInventory(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_INVENTORY(id), "GET");
        return response;
    }

    public List<InventoriesActivities> getInventoryActivities(String id) {
        JsonPath jsonPath = getInfoInventory(id).jsonPath();
        List<InventoriesActivities> inventoriesActivities = jsonPath.get("inventory_activities");
        return inventoriesActivities;
    }

    public List<HashMap> getInventoryItems(String id) {
        JsonPath jsonPath = getInfoInventory(id).jsonPath();
        List<HashMap> inventoryItems = jsonPath.get("inventory_items");
        return inventoryItems;
    }

    public void deleteAllSubtractionWithNoComment(String id) {
        List<HashMap> inventoryItems = getInventoryItems(id);
        Response response;
        if (inventoryItems.size() > 0) {
            for (int i = 0; i < inventoryItems.size(); i++) {
                if (inventoryItems.get(i).get("order_id") == null) {
                    Map<String, Object> map = new HashMap<>();
                    map.putIfAbsent("comment", "deleted");
                    response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_INVENTORY_ITEMS(String.valueOf(inventoryItems.get(i).get("id"))), map, "DELETE");
                    System.out.println(response.asString());
                }
            }
        }
    }

    public void callDeleteInventory(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_DELETE_INVENTORY(id), "DELETE");
//        System.out.println("RESPONSE DELETE INVENTORY " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE INVENTORY:  ").andContents(response.prettyPrint());
    }

    public Response callSearchInventory(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_INVENTORY, map, "GET");
//        System.out.println("RESPONSE SEARCH INVENTORY " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH INVENTORY:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetDetailInventory(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_INVENTORY(id), "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL INVENTORY:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callAdditionItem(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_INVENTORY_SUBTRACTION(id), map, "POST");
        return response;
    }

    public String getIdInventoryByLotCode(Response response, String lotcode) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> inventoryItems = jsonPath.get("results");
        String id = null;
        for (HashMap item : inventoryItems) {
            if (lotcode.equals(item.get("lot_code"))) {
                id = item.get("id").toString();
                break;
            }
        }
        return id;
    }

    public List<String> getIdInventoryByProduct(Response response, String product) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> inventoryItems = jsonPath.get("results");
        List<String> id = new ArrayList<>();
        for (HashMap item : inventoryItems) {
            if (item.get("product_name").toString().contains(product)) {
                id.add(item.get("id").toString());
            }
        }
        return id;
    }

    public List<String> getIdInventoryBySKU(Response response, String skuName) {
        JsonPath jsonPath = response.jsonPath();
        List<String> listID = new ArrayList<>();
        List<HashMap> inventoryItems = jsonPath.get("results");
        for (HashMap item : inventoryItems) {
            if (skuName.equals(item.get("product_variant_name"))) {
                listID.add(item.get("id").toString());
            }
        }
        return listID;
    }

    public void getIdInventoryItem(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> listIdWithdrawal = new ArrayList<>();
        List<String> listIdSubTraction = new ArrayList<>();
        List<String> pullDate = new ArrayList<>();
        List<HashMap> inventoryItems = jsonPath.get("inventory_items");
        for (HashMap item : inventoryItems) {
            // nếu inventory item có withdrawal request
            if (item.get("comment") != null) {
                if (item.get("comment").toString().contains("Created by withdraw request")) {
                    listIdWithdrawal.add(item.get("comment").toString().substring(27).trim());
                } // nếu inventory item có subtraction có comment
                if (item.get("comment").toString().equals("Autotest")) {
                    listIdSubTraction.add(item.get("id").toString());
                }// nếu inventory item có subtraction ko có comment
                if (item.get("comment").toString().equals("")) {
                    listIdSubTraction.add(item.get("id").toString());
                }// nếu inventory item có pull date reached
                if (item.get("comment").toString().contains("Pulldate")) {
                    pullDate.add(item.get("id").toString());
                }
            }
        }
        Serenity.setSessionVariable("List ID Withdrawal").to(listIdWithdrawal);
        Serenity.setSessionVariable("List ID Subtraction").to(listIdSubTraction);
        Serenity.setSessionVariable("List ID Pull Date").to(pullDate);
    }

    public List<HashMap> getIdSubtractionInventoryItem(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> listIdSubTraction = new ArrayList<>();
        List<String> pullDate = new ArrayList<>();
        List<HashMap> inventoryItems = jsonPath.get("inventory_items");
        for (HashMap item : inventoryItems) {
            // nếu inventory item có withdrawal request
            if (item.get("comment") != null) {
            } // nếu inventory item có subtraction có comment
            if (item.get("comment").toString().equals("Autotest")) {
                listIdSubTraction.add(item.get("id").toString());
            }// nếu inventory item có subtraction ko có comment
            if (item.get("comment").toString().equals("")) {
                listIdSubTraction.add(item.get("id").toString());
            }// nếu inventory item có pull date reached
            if (item.get("comment").toString().contains("Pulldate")) {
                pullDate.add(item.get("id").toString());
            }

        }
        Serenity.setSessionVariable("List ID Subtraction").to(listIdSubTraction);
        Serenity.setSessionVariable("List ID Pull Date").to(pullDate);
        return inventoryItems;
    }

    public Response callCreateSubtractionInventory(Map<String, Object> map, String id) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_INVENTORY_SUBTRACTION(id), map, "POST");
        System.out.println("RESPONSE CREATE SUBTRACTION " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SUBTRACTION:  ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setModelCreateSubtractionInventory(Map<String, String> info) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> inventory_item = new HashMap<>();
        inventory_item.put("subtraction_category_id", Integer.parseInt(info.get("subtraction_category_id")));
        inventory_item.put("quantity", Integer.parseInt(info.get("quantity")));
        inventory_item.put("comment", info.get("comment"));
        inventory_item.put("action", "subtract");
        map.put("inventory_item", inventory_item);
        return map;
    }

    public Map<String, Object> setModelCreateAdditionInventory(Map<String, Object> info) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> inventory_item = new HashMap<>();
        inventory_item.put("action", info.get("action"));
        inventory_item.put("addition_category_id", Integer.parseInt(info.get("addition_category_id").toString()));
        inventory_item.put("comment", info.get("comment"));
        inventory_item.put("quantity", Integer.parseInt(info.get("quantity").toString()));
        if(info.containsKey("subtraction_category_id")) {
            inventory_item.put("subtraction_category_id", Integer.parseInt(info.get("subtraction_category_id").toString()));
        }
        map.put("inventory_item", inventory_item);
        return map;
    }
}
