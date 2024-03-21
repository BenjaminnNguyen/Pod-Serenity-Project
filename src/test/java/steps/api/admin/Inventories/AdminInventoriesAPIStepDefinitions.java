package steps.api.admin.Inventories;

import com.google.gson.internal.bind.util.ISO8601Utils;
import cucumber.models.api.CreateInventory;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.Utility;
import io.cucumber.java.en.*;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.inventory.InventoryAPI;
import cucumber.tasks.api.admin.inventory.WithdrawalAdminAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.it.Ma;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminInventoriesAPIStepDefinitions {

    CommonRequest commonRequest = new CommonRequest();
    InventoryAPI inventoryAPI = new InventoryAPI();
    WithdrawalAdminAPI withdrawalAdminAPI = new WithdrawalAdminAPI();

    @And("Admin delete all subtraction of inventory {string}")
    public void deleteAllSubtraction(String idInventory) {
        if (idInventory.equals("")) {
            idInventory = Serenity.sessionVariableCalled("ID Inventory Admin");
        }
        if (idInventory != null) {
            inventoryAPI.deleteAllSubtractionWithNoComment(idInventory);
        }
    }

    @And("Admin delete all subtraction of list inventory")
    public void delete_all_subtraction_of_list_inventory() {
        List<String> listID = Serenity.sessionVariableCalled("List ID Inventory Admin");
        if (listID.size() != 0) {
            for (String id : listID) {
                inventoryAPI.deleteAllSubtractionWithNoComment(id);
            }
        }
    }

    @And("Admin delete inventory {string} by API")
    public void delete_inventory(String id) {
        List<String> listID = new ArrayList<>();
        if (id.equals("")) {
            id = Serenity.sessionVariableCalled("ID Inventory Admin");
            listID.add(id);
        }
        if (id.equals("all")) {
            listID = Serenity.sessionVariableCalled("List ID Inventory Admin");
        }
        for (String id1 : listID) {
            // Get detail inventory xem có order hay withdrawal request không để xóa
            Response response = inventoryAPI.callGetDetailInventory(id1);
            inventoryAPI.getIdInventoryItem(response);
            // delete subtraction nếu có
            List<String> listIdSubTraction = Serenity.sessionVariableCalled("List ID Subtraction");
            if (listIdSubTraction.size() > 0) {
                inventoryAPI.deleteAllSubtractionWithNoComment(id1);

            }
            // delete pull date nếu có
            List<String> listIdPullDate = Serenity.sessionVariableCalled("List ID Pull Date");
            if (listIdPullDate.size() > 0) {
                for (String item : listIdPullDate) {
                    inventoryAPI.deleteAllSubtractionWithNoComment(id1);
                }
            }
            // task mới chỉ cho cancel withdrawal ko cho delete
//            // delete withdrawal item nếu có
//            List<String> listIdWithdrawal = Serenity.sessionVariableCalled("List ID Withdrawal");
//            if (listIdWithdrawal.size() > 0) {
//                for (String item : listIdWithdrawal) {
//                    Response responseGetDetailWithdrawal = withdrawalAdminAPI.callDetailWithdrawal(item);
//                    // chỉ xóa withdrawal nếu ko completed
//                    if (!withdrawalAdminAPI.getStatusWithdrawal(responseGetDetailWithdrawal).equals("completed")) {
//                        withdrawalAdminAPI.callDeleteWithdrawal(item);
//                    }
//                }
//            }
            // Delete inventory
            inventoryAPI.callDeleteInventory(id1);
        }
    }

    @And("Admin delete all inventory by API")
    public void delete_all_inventory() {
        List<String> listID = Serenity.sessionVariableCalled("List ID Inventory Admin");
        for (String id : listID) {
            inventoryAPI.callDeleteInventory(id);
        }
    }

    @And("Admin search inventory by API")
    public void search_inventory(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        HashMap<String, Object> info1 = CommonTask.setValueRandom1(infoObj.get(0), "q[product_variant_name]", Serenity.sessionVariableCalled("SKU inventory"));
        Response response = inventoryAPI.callSearchInventory(info1);
        Serenity.setSessionVariable("Response Search Inventory").to(response);
    }

    @And("Admin get ID inventory by lotcote {string} from API")
    public void get_id_inventory_by_lotcode_from_api(String lotCode) {
        if (lotCode.equals("")) {
            lotCode = Serenity.sessionVariableCalled("Lot Code");
            System.out.println("LOT CODE " + lotCode);
        }
        Response response = Serenity.sessionVariableCalled("Response Search Inventory");
        String id = inventoryAPI.getIdInventoryByLotCode(response, lotCode);
        Serenity.setSessionVariable("ID Inventory Admin").to(id);
        System.out.println("ID " + id);
    }

    @And("Admin get ID inventory by product {string} from API")
    public void get_id_inventory_by_product_from_api(String product) {
        Response response = Serenity.sessionVariableCalled("Response Search Inventory");
        List<String> id = inventoryAPI.getIdInventoryByProduct(response, product);
        Serenity.setSessionVariable("List ID Inventory Admin").to(id);
        System.out.println("ID Inventory" + id);
    }

    @And("Admin get list ID inventory by sku {string} from API")
    public void get_list_id_inventory_by_sku_from_api(String sku) {
        if (sku.equals("")) {
            sku = Serenity.sessionVariableCalled("SKU inventory");
        }
        System.out.println("SKU get list = " + sku);
        Response response = Serenity.sessionVariableCalled("Response Search Inventory");
        List<String> listID = inventoryAPI.getIdInventoryBySKU(response, sku);
        Serenity.setSessionVariable("List ID Inventory Admin").to(listID);
        for (String id : listID) {
            System.out.println("ID= " + id);
        }
    }

    @And("Delete all inventory with product {string}")
    public void deleteInventory(String prd) {
        String basePath = UrlAdminAPI.ADMIN_GET_INVENTORY;
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("sort", "current_quantity");
        map.putIfAbsent("direction", "desc");
        map.putIfAbsent("q[product_name]", prd);
        Response response = commonRequest.commonRequestWithParam(basePath, map, "GET");
        for (String i : inventoryAPI.getIdInventory(response)) {
            commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_INVENTORY(i), "DELETE");
        }
    }

    @And("Delete all Inbound inventory with brand {string}")
    public void deleteInboundInventory(String prd) {
        String basePath = UrlAdminAPI.ADMIN_GET_INBOUND_INVENTORY;
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[brand_id]", prd);
        map.putIfAbsent("per_page", "48");
        Response response = commonRequest.commonRequestWithParam(basePath, map, "GET");
        for (String i : inventoryAPI.getIdInventory(response)) {
            commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_DELETE_INBOUND_INVENTORY(i), "DELETE");
        }
    }

    @And("Admin create inventory api")
    public void createInventory(CreateInventory createInventory) {
        String basePath = UrlAdminAPI.ADMIN_CREATE_INVENTORY;

        createInventory.setExpiry_date(CommonHandle.setDate2(createInventory.getExpiry_date(), "yyyy-MM-dd"));
        createInventory.setReceive_date(CommonHandle.setDate2(createInventory.getReceive_date(), "yyyy-MM-dd"));
        if (createInventory.getLot_code().equals("random")) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code").to(lotCode);
            createInventory.setLot_code(lotCode);
        }

        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("inventory", createInventory);
        Response response = commonRequest.commonRequestWithBody(basePath, map, "POST");
        JsonPath jsonPath = response.jsonPath();
        Serenity.setSessionVariable("Inventory ID").to(jsonPath.get("id"));
    }

    @And("Admin create inventory api1")
    public void createInventory1(List<Map<String, String>> infos) {
//        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String basePath = UrlAdminAPI.ADMIN_CREATE_INVENTORY;
        for (Map<String, String> info : infos) {
            // xử lý ID nếu SKU mới được tạo
            String product_variant_id = info.get("product_variant_id");
            String sku = info.get("sku");
            if (info.get("sku").equals("random")) {
                sku = Serenity.sessionVariableCalled("SKU inventory");
            }
            if (product_variant_id.equals("random")) {
                product_variant_id = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            if (product_variant_id.equals("auto create manual")) {
                product_variant_id = Serenity.sessionVariableCalled("SKU ID " + sku);
            }
            CreateInventory createInventory = new CreateInventory(Integer.parseInt(product_variant_id), Integer.parseInt(info.get("quantity")), info.get("lot_code"),
                    Integer.parseInt(info.get("warehouse_id").contains("api") ? Serenity.sessionVariableCalled("Distribution Center ID") : info.get("warehouse_id")),
                    CommonHandle.setDate2(info.get("receive_date"), "yyyy-MM-dd"), CommonHandle.setDate2(info.get("expiry_date"), "yyyy-MM-dd"), info.get("comment"));
            if (createInventory.getLot_code().equals("random")) {
                String lotCode = "Lot code" + Utility.getRandomString(5);
                Serenity.setSessionVariable("Lot Code").to(lotCode);
                Serenity.setSessionVariable("Lot Code" + sku + info.get("index")).to(lotCode);
                Serenity.setSessionVariable(info.get("lot_code") + info.get("index")).to(lotCode);
                createInventory.setLot_code(lotCode);
                System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + sku + info.get("index")));
            }

            Map<String, Object> map = new HashMap<>();
            map.putIfAbsent("inventory", createInventory);
            Response response = commonRequest.commonRequestWithBody(basePath, map, "POST");
            System.out.println("CREATE INVENTORY RESPONSE: " + response.prettyPrint());
            JsonPath jsonPath = response.jsonPath();
            Serenity.setSessionVariable("Inventory ID" + sku + info.get("index")).to(jsonPath.get("id"));
            Serenity.setSessionVariable("Id Inventory api").to(jsonPath.get("id"));
            Serenity.setSessionVariable("Lot code Inventory api").to(jsonPath.get("lot_code"));
        }
    }

    @And("Admin create Subtraction of inventory {string} by API")
    public void createSubtraction(String id, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (id.contains("create by api"))
            id = Serenity.sessionVariableCalled("Id Inventory api").toString();
        Map<String, Object> map = inventoryAPI.setModelCreateSubtractionInventory(list.get(0));
        inventoryAPI.callCreateSubtractionInventory(map, id);
    }

    @And("Admin addition item of inventory {string} by API")
    public void addition_item_of_inventory(String id, DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        if (id.isEmpty()) {
            id = Serenity.sessionVariableCalled("ID Inventory Admin");
            System.out.println("ID INVENTORY to add " + id);
        }
        Map<String, Object> body = inventoryAPI.setModelCreateAdditionInventory(infoObj.get(0));
        Response response = inventoryAPI.callAdditionItem(id, body);
    }

}
