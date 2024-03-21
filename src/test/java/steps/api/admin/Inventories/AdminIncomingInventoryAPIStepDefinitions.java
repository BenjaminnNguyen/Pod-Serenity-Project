package steps.api.admin.Inventories;

import cucumber.singleton.UrlAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.inventory.AdminIncomingInventoryAPI;
import cucumber.tasks.api.admin.inventory.InventoryAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.internal.multipart.MultiPartSpecificationImpl;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.MultiPartSpecification;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminIncomingInventoryAPIStepDefinitions {

    CommonRequest commonRequest = new CommonRequest();
    InventoryAPI inventoryAPI = new InventoryAPI();
    AdminIncomingInventoryAPI incomingInventoryAPI = new AdminIncomingInventoryAPI();
//    WithdrawalAdminAPI withdrawalAdminAPI = new WithdrawalAdminAPI();

    @And("Admin create Incoming Inventory api")
    public void createIncomingInventory(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> skus = Serenity.sessionVariableCalled("List SKU Incoming Inventory");
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("inbound_inventory[region_id]", infos.get(0).get("region_id"));
        inbound.put("inbound_inventory[vendor_company_id]", infos.get(0).get("vendor_company_id"));
        inbound.put("inbound_inventory[num_of_pallet]", infos.get(0).get("num_of_pallet"));
        inbound.put("inbound_inventory[num_of_sellable_retail_case]", infos.get(0).get("num_of_sellable_retail_case"));
        inbound.put("inbound_inventory[estimated_covered_period]", infos.get(0).get("estimated_covered_period"));
        inbound.put("inbound_inventory[notes]", infos.get(0).get("notes"));
        inbound.put("inbound_inventory[admin_note]", infos.get(0).get("admin_note"));
        inbound.put("inbound_inventory[warehouse_id]", infos.get(0).get("warehouse_id"));
        inbound.put("inbound_inventory[num_of_master_carton]", infos.get(0).containsKey("num_of_master_carton") ? infos.get(0).get("num_of_master_carton") : "1");

        for (int i = 0; i < skus.size(); i++) {
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][product_variant_id]", skus.get(i).get("product_variant_id"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][vendor_company_id]", skus.get(i).get("vendor_company_id"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][quantity]", skus.get(i).get("quantity"));
        }

        Response response = incomingInventoryAPI.callCreateIncoming(inbound);
        incomingInventoryAPI.getIdInbound(response);
    }

    @And("Admin save inbound number by index {string}")
    public void admin_save_inbound_number_by_index(String index) {
        // save inbound Number
        String number = Serenity.sessionVariableCalled("Number Inbound Inventory api").toString();
        Serenity.setSessionVariable("Number Inbound Inventory api" + index).to(number);
        System.out.println("Number Inbound Inventory api " + number);
        // save inbound ID
        String id = Serenity.sessionVariableCalled("ID Inbound Inventory api").toString();
        Serenity.setSessionVariable("ID Inbound Inventory api" + index).to(id);
    }

    @And("Admin submit Incoming Inventory id {string} api")
    public void submitIncomingInventory(String id, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
        List<Map<String, String>> items = Serenity.sessionVariableCalled("inventories_attributes" + id);
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("inbound_inventory[delivery_method_id]", infos.get(0).get("delivery_method_id"));
        inbound.put("inbound_inventory[eta]", CommonHandle.setDate2(infos.get(0).get("eta"), "yyyy-MM-dd"));
        inbound.put("inbound_inventory[num_of_pallet]", infos.get(0).get("num_of_pallet"));
        inbound.put("inbound_inventory[num_of_sellable_retail_case]", infos.get(0).get("num_of_sellable_retail_case"));
        inbound.put("inbound_inventory[num_of_master_carton]", infos.get(0).get("num_of_master_carton"));
        inbound.put("inbound_inventory[num_of_retail_per_master_carton]", infos.get(0).get("num_of_retail_per_master_carton"));
        inbound.put("inbound_inventory[status]", infos.get(0).get("status"));
        inbound.put("inbound_inventory[total_weight]", infos.get(0).get("total_weight"));
        inbound.put("inbound_inventory[zip_code]", infos.get(0).get("zip_code"));
        inbound.put("inbound_inventory[admin_note]", infos.get(0).get("admin_note"));
        inbound.put("inbound_inventory[warehouse_id]", infos.get(0).get("warehouse_id"));
        inbound.put("inbound_inventory[other_detail]", infos.get(0).get("other_detail"));
        inbound.put("inbound_inventory[freight_carrier]", infos.get(0).get("freight_carrier"));
        inbound.put("inbound_inventory[tracking_number]", infos.get(0).get("tracking_number"));
        inbound.put("inbound_inventory[reference_number]", infos.get(0).get("reference_number"));
        inbound.put("inbound_inventory[transport_coordinator_name]", infos.get(0).get("transport_coordinator_name"));
        inbound.put("inbound_inventory[transport_coordinator_phone]", infos.get(0).get("transport_coordinator_phone"));
        for (int i = 0; i < items.size(); i++) {
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][id]", items.get(i).get("id"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][product_variant_id]", items.get(i).get("product_variant_id"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][lot_code]", items.get(i).get("lot_code"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][expiry_date]", items.get(i).get("expiry_date"));
            inbound.put("inbound_inventory[inventories_attributes][" + i + "][quantity]", items.get(i).get("quantity"));
        }
        incomingInventoryAPI.callSubmitIncoming(id, inbound);
    }

    @And("Admin Approve Incoming Inventory id {string} api")
    public void approveIncomingInventory(String id) {
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
        if (id.contains("create by vendor")) {
            id = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("inbound_inventory[status]", "approved");
        incomingInventoryAPI.callSubmitIncoming(id, inbound);
    }

    @And("Admin Process Incoming Inventory id {string} api")
    public void processIncomingInventory(String id) {
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
        if (id.contains("create by vendor")) {
            id = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("inbound_inventory[status]", "processed");
        Response response = incomingInventoryAPI.callSubmitIncoming(id, inbound);
        incomingInventoryAPI.getIDInventory(response);
    }

    @And("Admin upload file Incoming Inventory id {string} api")
    public void uploadIncomingInventory(String id, DataTable table) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(table);
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
        if (id.contains("create by vendor")) {
            id = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        File file = new File(System.getProperty("user.dir") + "/src/test/resources/files/data/" + list.get(0).get("fileBOL"));
        File file2 = new File(System.getProperty("user.dir") + "/src/test/resources/files/data/" + list.get(0).get("filePOD"));
        RequestSpecification requestSpecification = new RequestSpecBuilder().build();
        RequestSpecification requestSpecification2 = new RequestSpecBuilder().build();
        requestSpecification.multiPart("inbound_inventory[attachment]", file);
        requestSpecification2.multiPart("inbound_inventory[proof_of_delivery_attributes][attachment]", file2);
        Response response = incomingInventoryAPI.callUploadFilesIncoming(id, requestSpecification);
        Response response2 = incomingInventoryAPI.callUploadFilesIncoming(id, requestSpecification2);
        incomingInventoryAPI.getIDInventory(response);
    }

    @And("Admin Mark as received Incoming Inventory id {string} api")
    public void receivedIncomingInventory(String id) {
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
        if (id.contains("create by vendor")) {
            id = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("inbound_inventory[status]", "received");
        Response response = incomingInventoryAPI.callSubmitIncoming(id, inbound);
        incomingInventoryAPI.getIDInventory(response);
    }

    @And("Admin cancel Incoming Inventory by api")
    public void deleteIncomingInventory(DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        List<String> ids = Serenity.sessionVariableCalled("List id Inbound Inventory api");
        HashMap inbound_inventory = new HashMap();
        inbound_inventory.put("inbound_inventory", list.get(0));
        if (ids.size() > 0) {
            for (String id : ids)
                incomingInventoryAPI.callCancelIncoming(id, inbound_inventory);
        }

    }

    @And("Admin cancel Incoming Inventory id {string} by api")
    public void deleteIncomingInventory(String id, DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        id = id.contains("api") ? Serenity.sessionVariableCalled("ID Inbound Inventory api") : id;
        HashMap inbound_inventory = new HashMap();
        inbound_inventory.put("inbound_inventory", list.get(0));
        incomingInventoryAPI.callCancelIncoming(id, inbound_inventory);
    }

    @And("Admin search Incoming Inventory by api")
    public void searchIncomingInventory(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        Map<String, Object> filter = new HashMap<>();
        for (Map<String, String> map : infos) {
            if (map.get("field").toString().contains("number") && map.get("value").contains("create by api")) {
                filter.put(map.get("field").toString(), Serenity.sessionVariableCalled("Number Inbound Inventory api").toString());
            } else
                filter.put(map.get("field").toString(), map.get("value"));
        }
        Response response = incomingInventoryAPI.callSearchIncoming(filter);
        List<String> ids = incomingInventoryAPI.getListIdInbound(response);
    }

    @And("Admin add SKU to Incoming Inventory api")
    public void addSKUIncomingInventory(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> infos2 = new ArrayList<>();
//        if (Serenity.hasASessionVariableCalled("List SKU Incoming Inventory")) {
//            infos2 = Serenity.sessionVariableCalled("List SKU Incoming Inventory");
//        }

        for (Map<String, String> map : infos) {
            String productVariantID = map.get("product_variant_id");
            if (map.containsKey("skuName") && map.get("product_variant_id").equals("random")) {
                productVariantID = Serenity.sessionVariableCalled("itemCode" + map.get("skuName")).toString();
            } else if (map.get("product_variant_id").equals("random")) {
                productVariantID = Serenity.sessionVariableCalled("ID SKU Admin").toString();
            }
            HashMap<String, String> info1 = CommonTask.setValueRandom(map, "product_variant_id", productVariantID);
            infos2.add(info1);
        }
        Serenity.setSessionVariable("List SKU Incoming Inventory").to(infos2);
    }

    @And("Admin clear list sku inbound by API")
    public void admin_clear_list_sku_inbound_attributes_by_api() {
        if (Serenity.hasASessionVariableCalled("List SKU Incoming Inventory")) {
            Serenity.clearSessionVariable("List SKU Incoming Inventory");
        }
    }

    @And("Admin set items info to submit of Incoming Inventory {string} api")
    public void setSKUSubmitIncomingInventory(String id, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> items = new ArrayList<>();
        if (id.contains("api")) {
            id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        }
//        Lấy list item -> ids, variants
        incomingInventoryAPI.getItemsInbound(id);
        List<Map<String, Object>> inventories_attributes = Serenity.sessionVariableCalled("List items Inbound Inventory api");
        for (Map<String, Object> inventories_attribute : inventories_attributes) {
            for (Map<String, String> info : infos) {
                Map<String, String> item = new HashMap<>();
                if (inventories_attribute.get("product_variant_name").toString().contains(info.get("sku"))) {
                    item.put("id", inventories_attribute.get("id").toString());
                    item.put("product_variant_id", inventories_attribute.get("product_variant_id").toString());
                    item.put("lot_code", info.get("lot_code").toString());
                    item.put("quantity", info.get("quantity").toString());
                    item.put("expiry_date", CommonHandle.setDate2(info.get("expiry_date").toString(), "yyyy-MM-dd"));
//                    Set item info: lot code, quantity...
                    items.add(item);
                }
            }
        }
        Serenity.setSessionVariable("inventories_attributes" + id).to(items);
    }


    @And("Admin edit number of case Incoming Inventory api")
    public void editNumberCaseIncomingInventory(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        Map<String, Object> infos2 = new HashMap<>();
        String id = Serenity.sessionVariableCalled("ID Inbound Inventory api");
        incomingInventoryAPI.getItemsInbound(id);
        String inventories_attributes_id = "";
        List<Map<String, Object>> inventories_attributes = Serenity.sessionVariableCalled("List items Inbound Inventory api");
        for (Map<String, Object> inventories_attribute : inventories_attributes) {
            if (inventories_attribute.get("lot_code").toString().contains(info.get(0).get("lot_code"))) {
                inventories_attributes_id = inventories_attribute.get("id").toString();
            }
        }
        infos2.put("inbound_inventory[num_of_master_carton]", info.get(0).get("num_of_master_carton"));
        infos2.put("inbound_inventory[inventories_attributes][0][id]", inventories_attributes_id);
        infos2.put("inbound_inventory[inventories_attributes][0][quantity]", info.get(0).get("quantity"));
        infos2.put("inbound_inventory[inventories_attributes][0][status]", info.get(0).get("status"));
        infos2.put("inbound_inventory[inventories_attributes][0][lot_code]", info.get(0).get("lot_code"));
        infos2.put("inbound_inventory[inventories_attributes][0][expiry_date]", CommonHandle.setDate2(info.get(0).get("expiry_date"), "yyyy-MM-dd"));
        Response response = incomingInventoryAPI.callEDITIncoming(id, infos2);
    }
}
