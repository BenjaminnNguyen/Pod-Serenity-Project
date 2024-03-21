package steps.api.admin.Inventories;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import io.cucumber.java.en.*;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.inventory.WithdrawalAdminAPI;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import okhttp3.*;
import org.apache.http.entity.mime.MultipartEntityBuilder;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class AdminWithdrawalAPIStepDefinitions {
    WithdrawalAdminAPI withdrawalAdminAPI = new WithdrawalAdminAPI();

    @And("Admin search withdrawal by API")
    public void admin_search_withdrawal_by_api(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, Object> info = new HashMap<>(infos.get(0));
        info.replace("q[start_date]", CommonHandle.setDate2(info.get("q[start_date]").toString(), "yyyy-MM-dd"));
        info.replace("q[end_date]", CommonHandle.setDate2(info.get("q[end_date]").toString(), "yyyy-MM-dd"));
        info = CommonTask.setValue1(info, "q[number]", info.get("q[number]").toString(), Serenity.sessionVariableCalled("Number Withdraw request api"), "create by api");
        Response response = withdrawalAdminAPI.callSearchWithdrawal(info);
        Serenity.setSessionVariable("Response Search Withdrawal").to(response);
    }

    @And("Admin delete all ID of withdrawal request of SKU {string} by api")
    public void admin_delete_all_id_of_withdrawal_by_api(String skuName) {
        Response response = Serenity.sessionVariableCalled("Response Search Withdrawal");
        if (skuName.equals("")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        List<String> listID = withdrawalAdminAPI.getListIdWithdrawal(response);
        for (String id : listID) {
            System.out.println("List ID " + id);
            // get detail của withdrawal để tìm xem withdrawl nào của sku cần tìm
            Response responseDetail = withdrawalAdminAPI.callDetailWithdrawal(id);
            if (withdrawalAdminAPI.checkSkuInWithdrawDetail(responseDetail, skuName)) {
                System.out.println("ID delete " + id);
                Response responseDelete = withdrawalAdminAPI.callDeleteWithdrawal(id);
                withdrawalAdminAPI.verifyDeleteSuccess(responseDelete);
            }
        }
    }

    @And("Admin approve withdrawal request {string} by api")
    public void admin_approve_withdrawal_by_api(String id) {
        if (id.equals("create by api")) {
            id = Serenity.sessionVariableCalled("Id Withdraw request api");
        }
        if (id.equals("create by vendor")) {
            id = Serenity.sessionVariableCalled("Withdrawal Request ID");
        }
        Response response = withdrawalAdminAPI.callApproveWithdrawal(id);
    }

    @And("Admin complete withdrawal request {string} by api")
    public void admin_complete_withdrawal_by_api(String id) {
        String id_ = id;
        if (id.equals("create by api")) {
            id_ = Serenity.sessionVariableCalled("Id Withdraw request api");
        }
        if (id.equals("create by vendor")) {
            id_ = Serenity.sessionVariableCalled("Withdrawal Request ID");
        }
        Response response = withdrawalAdminAPI.callCompleteWithdrawal(id_);
    }

    @And("Admin add Lot code to withdraw request api")
    public void addLotCodeWithdraw(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> infos2 = new ArrayList<>();
        if (Serenity.hasASessionVariableCalled("List Lot Code Withdraw Request api")) {
            infos2 = Serenity.sessionVariableCalled("List Lot Code Withdraw Request api");
        }
        for (Map<String, String> map : infos) {
            HashMap<String, String> info1 = CommonTask.setValueRandom(map, "product_variant_id", Serenity.sessionVariableCalled("ID SKU Admin").toString());
            info1 = CommonTask.setValueRandom(info1, "inventory_id", Serenity.sessionVariableCalled("Id Inventory api").toString());
            infos2.add(info1);
        }
        Serenity.setSessionVariable("List Lot Code Withdraw Request api").to(infos2);
    }

    @And("Admin create withdraw request api")
    public void createIncomingInventory(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> skus = Serenity.sessionVariableCalled("List Lot Code Withdraw Request api");
        Map<String, Object> inbound = new HashMap<>();
        inbound.put("withdraw_inventory[vendor_company_id]", infos.get(0).get("vendor_company_id"));
        inbound.put("withdraw_inventory[region_id]", infos.get(0).get("region_id"));
        inbound.put("withdraw_inventory[pickup_date]", CommonHandle.setDate2(infos.get(0).get("pickup_date"), "yyyy-MM-dd"));
        inbound.put("withdraw_inventory[start_time]", infos.get(0).get("start_time"));
        inbound.put("withdraw_inventory[end_time]", infos.get(0).get("end_time"));
        inbound.put("withdraw_inventory[pickup_type]", infos.get(0).get("pickup_type"));
        inbound.put("withdraw_inventory[pickup_partner_name]", infos.get(0).get("pickup_partner_name"));
        inbound.put("withdraw_inventory[pallet_weight]", infos.get(0).get("pallet_weight"));
        inbound.put("withdraw_inventory[comment]", infos.get(0).get("comment"));
        inbound.put("withdraw_inventory[attachment]", infos.get(0).get("attachment"));
        for (int i = 0; i < skus.size(); i++) {
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_id]", skus.get(i).get("inventory_id"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_lot_code]", skus.get(i).get("inventory_lot_code"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][product_variant_id]", skus.get(i).get("product_variant_id"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][quantity]", skus.get(i).get("quantity"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][pull_quantity]", skus.get(i).get("pull_quantity"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][withdraw_case]", skus.get(i).get("withdraw_case"));
            inbound.put("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_expiry_date]", CommonHandle.setDate2(skus.get(i).get("inventory_expiry_date"), "yyyy-MM-dd"));
        }
        withdrawalAdminAPI.getIdWithdrawal(withdrawalAdminAPI.callCreateWithdrawal(inbound));
    }

    @And("Admin create withdraw request api2")
    public void createIncomingInventory2(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<Map<String, String>> skus = Serenity.sessionVariableCalled("List Lot Code Withdraw Request api");
        Map<String, Object> inbound = new HashMap<>();
        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File fileName1 = null;
        String file1 = "";
        if (!infos.get(0).get("attachment").isEmpty())
            try {
                fileName1 = new File(classLoader.getResource("Images/" + infos.get(0).get("attachment")).toURI().getPath());
                file1 = "/" + fileName1.getAbsolutePath().replaceAll("\\\\", "/");
            } catch (URISyntaxException e) {
                throw new RuntimeException(e);
            }
        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder
                .addFormDataPart("withdraw_inventory[vendor_company_id]", infos.get(0).get("vendor_company_id"))
                .addFormDataPart("withdraw_inventory[region_id]", infos.get(0).get("region_id"))
                .addFormDataPart("withdraw_inventory[pickup_date]", CommonHandle.setDate2(infos.get(0).get("pickup_date"), "yyyy-MM-dd"))
                .addFormDataPart("withdraw_inventory[start_time]", infos.get(0).get("start_time"))
                .addFormDataPart("withdraw_inventory[end_time]", infos.get(0).get("end_time"))
                .addFormDataPart("withdraw_inventory[pickup_type]", infos.get(0).get("pickup_type"))
                .addFormDataPart("withdraw_inventory[pickup_partner_name]", infos.get(0).get("pickup_partner_name"))
                .addFormDataPart("withdraw_inventory[pallet_weight]", infos.get(0).get("pallet_weight"))
                .addFormDataPart("withdraw_inventory[comment]", infos.get(0).get("comment"))
                .addFormDataPart("withdraw_inventory[attachment]", file1,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file1)));

        if (infos.get(0).containsKey("contact_email")) {
            builder.addFormDataPart("withdraw_inventory[contact_email]", infos.get(0).get("contact_email"));
        }
        for (int i = 0; i < skus.size(); i++) {
            builder.addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_id]", skus.get(i).get("inventory_id"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_lot_code]", skus.get(i).get("inventory_lot_code"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][product_variant_id]", skus.get(i).get("product_variant_id"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][quantity]", skus.get(i).get("quantity"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][pull_quantity]", skus.get(i).get("pull_quantity"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][withdraw_case]", skus.get(i).get("withdraw_case"))
                    .addFormDataPart("withdraw_inventory[withdraw_items_attributes][" + i + "][inventory_expiry_date]", CommonHandle.setDate2(skus.get(i).get("inventory_expiry_date"), "yyyy-MM-dd"));
        }
        RequestBody body = builder.build();
        if (infos.get(0).containsKey("index"))
            withdrawalAdminAPI.getIdWithdrawal2(withdrawalAdminAPI.callCreateWithdrawal(body), infos.get(0).get("index"));
        else
            withdrawalAdminAPI.getIdWithdrawal2(withdrawalAdminAPI.callCreateWithdrawal(body), "");

    }


}
