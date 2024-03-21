package steps.api.admin.financial;

import cucumber.tasks.api.admin.financial.HandleCreditMemoTypeAPI;
import cucumber.tasks.api.admin.financial.HandleStoreAdjustmentTypeAPI;
import cucumber.tasks.api.admin.financial.HandleVendorAdjustmentTypeAPI;
import io.cucumber.java.en.And;

import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.Map;


public class FinancialAPIStepDefinitions {
    HandleVendorAdjustmentTypeAPI vendorAdjustmentTypeAPI = new HandleVendorAdjustmentTypeAPI();
    HandleStoreAdjustmentTypeAPI storeAdjustmentTypeAPI = new HandleStoreAdjustmentTypeAPI();
    HandleCreditMemoTypeAPI creditMemoTypeAPI = new HandleCreditMemoTypeAPI();

    @And("Admin search vendor adjustment type {string} by api")
    public void search_vendor_adjustment_type_by_api(String name) {
        Map<String, Object> map = new HashMap<>();
        String id = null;
        int page = 1;
        while (id == null) {
            map.put("page", page);
            // search page
            Response response = vendorAdjustmentTypeAPI.callSearchAdjustmentType(map);
            id = vendorAdjustmentTypeAPI.getId(response, name);
            if (id != null) {
                break;
            }
            if (page == 5) {
                System.out.println("Không tìm thấy adjustment type");
                break;
            }
            // tăng page lên 1
            page = page + 1;
        }

        Serenity.setSessionVariable("ID Vendor Adjustment type").to(id);
    }

    @And("Admin delete vendor adjustment type by api")
    public void delete_vendor_adjustment_type_by_api() {
        String id = Serenity.sessionVariableCalled("ID Vendor Adjustment type");
        if (id != null) {
            vendorAdjustmentTypeAPI.callDeleteAdjustmentType(id);
        }
    }

    @And("Admin search store adjustment type {string} by api")
    public void search_store_adjustment_type_by_api(String name) {
        Map<String, Object> map = new HashMap<>();
        String id = null;
        int page = 1;
        while (id == null) {
            map.put("page", page);
            // search page
            Response response = storeAdjustmentTypeAPI.callSearchStoreAdjustmentType(map);
            id = storeAdjustmentTypeAPI.getId(response, name);
            if (id != null) {
                break;
            }
            if (page == 5) {
                System.out.println("Không tìm thấy store adjustment type");
                break;
            }
            // tăng page lên 1
            page = page + 1;
        }

        Serenity.setSessionVariable("ID Store Adjustment type").to(id);
    }

    @And("Admin delete store adjustment type by api")
    public void delete_store_adjustment_type_by_api() {
        String id = Serenity.sessionVariableCalled("ID Store Adjustment type");
        if (id != null) {
            storeAdjustmentTypeAPI.callDeleteStoreAdjustmentType(id);
        }
    }


    @And("Admin delete credit memo type by api")
    public void delete_credit_memo_type_by_api() {
        String id = Serenity.sessionVariableCalled("ID Credit Memo type");
        if (id != null) {
            creditMemoTypeAPI.callDeleteCreditMemoType(id);
        }
    }

    @And("Admin search credit memo type {string} by api")
    public void search_credit_memo_type_by_api(String name) {
        Map<String, Object> map = new HashMap<>();
        String id = null;
        int page = 1;
        while (id == null) {
            map.put("page", page);
            // search page
            Response response = creditMemoTypeAPI.callSearchCreditMemoType(map);
            id = creditMemoTypeAPI.getId(response, name);
            if (id != null) {
                break;
            }
            if (page == 5) {
                System.out.println("Không tìm thấy credit memo type");
                break;
            }
            // tăng page lên 1
            page = page + 1;
        }

        Serenity.setSessionVariable("ID Credit Memo type").to(id);
    }


}
